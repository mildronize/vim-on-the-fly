# Vim On The Fly

VIM on windows via Docker

> This project is under constructing. It's not ready to use

## Objective
- Run [VIM](https://github.com/vim/vim) on the fly on Windows

## Prerequistuse
- [Docker for windows](http://docs.docker.com/windows/step_one/)
- Optional: alternative power shell [Cmder](https://github.com/bliker/cmder)

## Prepare
Run Docoker via `Boot2docker Start` shortcut on the desktop   ![](http://docs.docker.com/windows/images/icon-set.png)

or by power shell

```
PS C:\> cd 'C:\Program Files\Boot2Docker for Windows'
PS C:\> sh start.sh
```

## Instruction
1. Make sure the Docker is running via `Boot2docker status`. It has to return `running`. If not go back to [previous section](#prepare)

2. Build

    ```
    PS C:\> docker build -t vim-on-the-fly .
    ```

3. Run the container
Can't  run terminal docker directly via `docker run -it vim-on-the-fly` use belowing instead

    ```
    PS C:\> docker run -d -P --name run-vimotf vim-on-the-fly
    PS C:\> docker port run-vimotf 22
    0.0.0.0:32772
    ```

4. Log in to it
    - **Method 1**: Through Docker VM

        Port `32772` which reached from No.3.

        ```
        PS C:\> boot2docker ssh
        $ ssh root@localhost -p 32772
        ```
    - **Method 2**: Through host
        To use `ssh` to `192.168.59.104` which is ip of docker VM and port `32772` which reached from No.3. The password is `vimotf` that is defined at `config/username`.

        ```
        PS C:\> ssh root@192.168.59.104 -p 32772
        ```

        > Note: You can get the IP of docker VM by `boot2docker ip`

5. Run vim, Cheer!

    ```
    vim
    ```

## Clean up
```
$ docker stop run-vimotf
$ docker rm run-vimotf
$ docker rmi vim-on-the-fly
```
