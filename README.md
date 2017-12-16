# Shiny Shell #

A Shiny app that provides a simple shell into the underlying operating system by passing input to the `system2` command. 

# WARNING #

_This is extremely unsecure_.  Use at your own risk.  By exposing this functionality to your users, you allow them the opportunity to execute arbitrary code on your operating system.  It can be useful for education, exploration, or as a simple example, but is generally recommended against at other times.  This functionality would make it much easier for a malicious user to fill up your server, crash your server, or hack your server.  As such, the execution environment would ideally be contained and controlled with a non-privileged user.

If you are going deeper into the realm of education, I recommend using the [`learnr`](https://rstudio.github.io/learnr/) package to build helpful tutorials with similar interactive functionality.  

Have fun and stay safe!!