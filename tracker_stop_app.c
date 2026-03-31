#include <spawn.h>
#include <stdio.h>
#include <sys/wait.h>
#include <time.h>

extern char **environ;

static void append_log(const char *message) {
    FILE *file = fopen("/tmp/trainings-tracker-stop-app.log", "a");
    if (!file) return;
    time_t now = time(NULL);
    fprintf(file, "%ld %s\n", (long)now, message);
    fclose(file);
}

int main(void) {
    append_log("stop launcher started");

    char *args[] = {
        "/bin/bash",
        "/Users/TUM/Desktop/USC Minijob Tracker/stop.command",
        NULL
    };

    pid_t pid;
    int status = 0;
    int spawn_result = posix_spawn(&pid, "/bin/bash", NULL, NULL, args, environ);
    if (spawn_result != 0) {
        append_log("stop spawn failed");
        return spawn_result;
    }
    if (waitpid(pid, &status, 0) == -1) {
        append_log("stop waitpid failed");
        return 1;
    }
    if (WIFEXITED(status)) {
        append_log("stop launcher finished");
        return WEXITSTATUS(status);
    }
    return 1;
}
