standard_scripts
================

Standard shell scripts used in an operations environment.

Logging:

* Set the AUDIT_LOG & DETAIL_LOG variables to file paths BEFORE sourcing "error_handling.sh" to use those paths as logs.

Error handling:

* To automatically catch & report all errors in your scripts, source the "error_handling.sh" file.
* To disable error handling (handle the error yourself without abending), source the "rm_error_handling.sh" file.
* Enable & disable error handling as often as you need in the same script.

Example:

* Here is an example run of the "test.sh" script. 
* The "test.sh" script has 3 fake commands in it which will cause errors when executed.
* The first one is handled by the "test.sh" script itself, the second one is caught & handled by "error_handling.sh" and the third is never reached becaue the second one causes the script to abend.

  stdout:

    devops001@ubuntu:~/github/standard_scripts> ./test.sh
    begin
    ./test.sh: line 25: fake1: command not found
    fake1 command failed. it returned: 127
    ./test.sh: line 37: fake2: command not found
    20140821.1444.24 | test.sh | abended on line number 37 (runtime user: devops001)

  logging:

    devops001@ubuntu:~/github/standard_scripts> cat logs/audit.log 
    20140821.1444.24 | test.sh | abended on line number 37 (runtime user: devops001)

    devops001@ubuntu:~/github/standard_scripts> cat logs/detail.log 
    20140821.1444.24 | test.sh | error_handling.sh was called.
    20140821.1444.24 | test.sh | rm_error_handling.sh was called.
    ./test.sh: line 25: fake1: command not found
    20140821.1444.24 | test.sh | error_handling.sh was called.
    ./test.sh: line 37: fake2: command not found
    20140821.1444.24 | test.sh | abended on line number 37 (runtime user: devops001)

