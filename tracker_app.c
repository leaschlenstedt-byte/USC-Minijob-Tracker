#include <spawn.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

extern char **environ;

static void append_log(const char *message) {
    FILE *file = fopen("/tmp/trainings-tracker-app.log", "a");
    if (!file) return;
    time_t now = time(NULL);
    fprintf(file, "%ld %s\n", (long)now, message);
    fclose(file);
}

static int run_process(const char *path, char *const argv[]) {
    pid_t pid;
    int status = 0;
    int spawn_result = posix_spawn(&pid, path, NULL, NULL, argv, environ);
    if (spawn_result != 0) {
        append_log("posix_spawn failed");
        return spawn_result;
    }
    if (waitpid(pid, &status, 0) == -1) {
        append_log("waitpid failed");
        return 1;
    }
    if (WIFEXITED(status)) return WEXITSTATUS(status);
    return 1;
}

int main(void) {
    append_log("launcher started");

    char *launch_args[] = {
        "/usr/bin/python3",
        "/Users/TUM/Desktop/USC Minijob Tracker/launch_server.py",
        NULL
    };
    int launch_status = run_process("/usr/bin/python3", launch_args);
    if (launch_status != 0) {
        append_log("launch_server.py failed");
        return launch_status;
    }

    if (access("/Applications/Google Chrome.app", F_OK) == 0) {
        char *open_args[] = {
            "/usr/bin/open",
            "-na",
            "Google Chrome",
            "--args",
            "--app=http://127.0.0.1:8000",
            NULL
        };
        int open_status = run_process("/usr/bin/open", open_args);
        append_log(open_status == 0 ? "chrome open ok" : "chrome open failed");
        return open_status;
    }

    char *open_args[] = {
        "/usr/bin/open",
        "http://127.0.0.1:8000",
        NULL
    };
    int open_status = run_process("/usr/bin/open", open_args);
    append_log(open_status == 0 ? "url open ok" : "url open failed");
    return open_status;
}
