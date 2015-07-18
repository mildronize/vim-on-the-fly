# Vim On The Fly

VIM on windows via Docker

> This project is under constructing. It's not ready to use

## Objective
- Run [VIM](https://github.com/vim/vim) on the fly on Windows

## Prerequistuse
- [Docker for windows](http://docs.docker.com/windows/step_one/)
- Optional: alternative power shell [Cmder](https://github.com/bliker/cmder)

> Note: Remember the ip of docker when docker started.
```
IP address of docker VM:
192.168.59.104
```

## Instruction
1. Build

    ```
    $ docker build -t vim-on-the-fly .
    ```

2. Run the container
Can't  run terminal docker directly via `docker run -it vim-on-the-fly` use belowing intead

    ```
    $ docker run -d -P --name run-vimotf vim-on-the-fly
    $ docker port run-vimotf 22
    0.0.0.0:32772
    ```

3. Log in to it
    To use `ssh` to `192.168.59.104` which is ip of docker VM and port `32772` which reached from No.2. The password is `vimotf` that is defined at `config/username`.
    ```
    $ ssh root@192.168.59.104 -p 32772
    ```

4. Run vim, Cheer!

    ```
    vim
    ```

## Clean up
```
$ docker stop run-vimotf
$ docker rm run-vimotf
$ docker rmi vim-on-the-fly
```
