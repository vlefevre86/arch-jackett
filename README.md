Jackett
======

Jackett - https://github.com/Jackett/Jackett

Latest Jackett git release.

**Pull image**

```
docker pull vlefevre86/arch-jackett
```

**Run container**

```
docker run -d -p 9117:9117 --name=<container name> -v <path for config files>:/config -v <path for jackett files>:/usr/share/Jackett/.config/Jackett/ -v /etc/localtime:/etc/localtime:ro vlefevre86/arch-jackett
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access Jackett**

```
http://<host ip>:9117
```

**Credits** 

Thanks to [binhex](https://github.com/binhex) who provided the base (I stole most of the code ;-) )
