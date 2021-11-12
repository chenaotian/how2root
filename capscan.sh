#!/bin/bash
#danger
CAP_CHOWN=1+CAP_CHOWN
CAP_DAC_OVERRIDE=`echo 1 | awk '{print lshift($0,1)}'`+CAP_DAC_OVERRIDE
CAP_DAC_READ_SEARCH=`echo 1 | awk '{print lshift($0,2)}'`+CAP_DAC_READ_SEARCH
CAP_FOWNER=`echo 1 | awk '{print lshift($0,3)}'`+CAP_FOWNER
CAP_SETGID=`echo 1 | awk '{print lshift($0,6)}'`+CAP_SETGID
CAP_SETUID=`echo 1 | awk '{print lshift($0,7)}'`+CAP_SETUID
CAP_NET_ADMIN=`echo 1 | awk '{print lshift($0,12)}'`+CAP_NET_ADMIN
CAP_IPC_OWNER=`echo 1 | awk '{print lshift($0,15)}'`+CAP_IPC_OWNER
CAP_SYS_MODULE=`echo 1 | awk '{print lshift($0,16)}'`+CAP_SYS_MODULE
CAP_SYS_PTRACE=`echo 1 | awk '{print lshift($0,19)}'`+CAP_SYS_PTRACE
CAP_SETFCAP=`echo 1 | awk '{print lshift($0,31)}'`+CAP_SETFCAP
dangerCap="$CAP_CHOWN $CAP_DAC_OVERRIDE $CAP_DAC_READ_SEARCH $CAP_FOWNER $CAP_SETGID $CAP_SETUID $CAP_NET_ADMIN $CAP_IPC_OWNER $CAP_SYS_MODULE $CAP_SYS_PTRACE $CAP_SETFCAP"
#normal
CAP_FSETID=`echo 1 | awk '{print lshift($0,4)}'`+CAP_FSETID
CAP_KILL=`echo 1 | awk '{print lshift($0,5)}'`+CAP_KILL
CAP_SETPCAP=`echo 1 | awk '{print lshift($0,8)}'`+CAP_SETPCAP
CAP_LINUX_IMMUTABLE=`echo 1 | awk '{print lshift($0,9)}'`+CAP_LINUX_IMMUTABLE
CAP_NET_BIND_SERVICE=`echo 1 | awk '{print lshift($0,10)}'`+CAP_NET_BIND_SERVICE
CAP_NET_BROADCAST=`echo 1 | awk '{print lshift($0,11)}'`+CAP_NET_BROADCAST
CAP_NET_RAW=`echo 1 | awk '{print lshift($0,13)}'`+CAP_NET_RAW
CAP_IPC_LOCK=`echo 1 | awk '{print lshift($0,14)}'`+CAP_IPC_LOCK
CAP_SYS_RAWIO=`echo 1 | awk '{print lshift($0,17)}'`+CAP_SYS_RAWIO
CAP_SYS_CHROOT=`echo 1 | awk '{print lshift($0,18)}'`+CAP_SYS_CHROOT
CAP_SYS_PACCT=`echo 1 | awk '{print lshift($0,20)}'`+CAP_SYS_PACCT
CAP_SYS_ADMIN=`echo 1 | awk '{print lshift($0,21)}'`+CAP_SYS_ADMIN
CAP_SYS_BOOT=`echo 1 | awk '{print lshift($0,22)}'`+CAP_SYS_BOOT
CAP_SYS_NICE=`echo 1 | awk '{print lshift($0,23)}'`+CAP_SYS_NICE
CAP_SYS_RESOURCE=`echo 1 | awk '{print lshift($0,24)}'`+CAP_SYS_RESOURCE
CAP_SYS_TIME=`echo 1 | awk '{print lshift($0,25)}'`+CAP_SYS_TIME
CAP_SYS_TTY_CONFIG=`echo 1 | awk '{print lshift($0,26)}'`+CAP_SYS_TTY_CONFIG
CAP_MKNOD=`echo 1 | awk '{print lshift($0,27)}'`+CAP_MKNOD
CAP_LEASE=`echo 1 | awk '{print lshift($0,28)}'`+CAP_LEASE
CAP_AUDIT_WRITE=`echo 1 | awk '{print lshift($0,29)}'`+CAP_AUDIT_WRITE
CAP_AUDIT_CONTROL=`echo 1 | awk '{print lshift($0,30)}'`+CAP_AUDIT_CONTROL
CAP_MAC_OVERRIDE=`echo 1 | awk '{print lshift($0,32)}'`+CAP_MAC_OVERRIDE
CAP_MAC_ADMIN=`echo 1 | awk '{print lshift($0,33)}'`+CAP_MAC_ADMIN
CAP_SYSLOG=`echo 1 | awk '{print lshift($0,34)}'`+CAP_SYSLOG
CAP_WAKE_ALARM=`echo 1 | awk '{print lshift($0,35)}'`+CAP_WAKE_ALARM
CAP_BLOCK_SUSPEND=`echo 1 | awk '{print lshift($0,36)}'`+CAP_BLOCK_SUSPEND
CAP_AUDIT_READ=`echo 1 | awk '{print lshift($0,37)}'`+CAP_AUDIT_READ
allCap="$dangerCap $CAP_FSETID $CAP_KILL $CAP_SETPCAP $CAP_LINUX_IMMUTABLE $CAP_NET_BIND_SERVICE $CAP_NET_BROADCAST $CAP_NET_RAW $CAP_IPC_LOCK $CAP_SYS_RAWIO $CAP_SYS_CHROOT $CAP_SYS_PACCT $CAP_SYS_ADMIN $CAP_SYS_BOOT $CAP_SYS_NICE $CAP_SYS_RESOURCE $CAP_SYS_TIME $CAP_SYS_TTY_CONFIG $CAP_MKNOD $CAP_LEASE $CAP_AUDIT_WRITE $CAP_AUDIT_CONTROL $CAP_MAC_OVERRIDE $CAP_MAC_ADMIN $CAP_SYSLOG $CAP_WAKE_ALARM $CAP_BLOCK_SUSPEND $CAP_AUDIT_READ"

script_name=`basename $0`

function show_help_info()
{
cat<<EOF
Usage: $script_name [OPTION]...
Search all thread which have danger capbilities.

Example:
$script_name
$script_name --showroot -c CAP_DAC_OVERRIDE,CAP_SETUID

Mandatory arguments to long options are mandatory for short options too.
        --showroot  Show root's thread in result
                    Default show thread that uid not 0

    -c, --cap       Only search thread with capbilities that you specified
                    Only uppercase capbilities is supported
                    Default mode only search thread with danger capbilities like these:
                    CAP_CHOWN CAP_DAC_OVERRIDE CAP_DAC_READ_SEARCH CAP_FOWNER CAP_SETGID 
                    CAP_SETUID CAP_NET_ADMIN CAP_IPC_OWNER CAP_SYS_MODULE CAP_SYS_PTRACE CAP_SETFCAP

    -a, --all       Show thread with any capbility

    -h, --help      Show help information
EOF
}

function findCap()
{
    status=`cat /proc/$1/status`
    uid=${status#*Uid:}
    uid=${uid%%Gid*}

    if [ $2 == 0 -a ${uid: 1: 1} == 0 ]
    then
        return
    fi
    CapPrm=${status#*CapPrm:}
    CapPrm=${CapPrm%%CapEff*}
    CapPrm=${CapPrm: 1: 16}
    let CapPrm=0x${CapPrm}

    CapEff=${status#*CapEff:}
    CapEff=${CapEff%%CapEff*}
    CapEff=${CapEff: 1: 16}
    let CapEff=0x${CapEff}

    prmDanCapStr=""
    effDanCapStr=""
    if [ $3 == 0 ]
    then
        for eachCap in ${dangerCap}
        do
            let tmpCapVal=${eachCap%%+*}
            tmpCapStr=${eachCap#*+}

            if [ $((($CapPrm)&$tmpCapVal)) != 0 ]
            then
                prmDanCapStr=$prmDanCapStr$tmpCapStr", "
            fi
            if [ $((($CapEff)&$tmpCapVal)) != 0 ]
            then
                effDanCapStr=$effDanCapStr$tmpCapStr", "
            fi
        done
    else
        for eachCap in ${4//,/ }
        do
            for maybeCap in ${allCap}
            do
                let tmpCapVal=${maybeCap%%+*}
                tmpCapStr=${maybeCap#*+}

                if [ $tmpCapStr != $eachCap ]
                then
                    continue
                fi
                if [ $((($CapPrm)&$tmpCapVal)) != 0 ]
                then
                    prmDanCapStr=$prmDanCapStr$tmpCapStr", "
                fi
                if [ $((($CapEff)&$tmpCapVal)) != 0 ]
                then
                    effDanCapStr=$effDanCapStr$tmpCapStr", "
                fi
                break
            done
        done
    fi

    if [ ${#prmDanCapStr} == 0 ]
    then
        if [ ${#effDanCapStr} == 0 ]
        then
            return
        fi
    fi

    printStr="-----------------------------------------------------\n[+] PID: $1\n[+] EXE: "
    if [ -f /proc/$1/exe ]
    then
        exe=`ls -al /proc/$1/exe`
        exe=${exe#*->}
    else
        exe=""
    fi
    printStr=$printStr$exe"\n[+] UID: "
    printStr=$printStr$uid"\n[+] CapPrm: "
    printStr=$printStr$prmDanCapStr"\n[+] CapEff: "
    printStr=$printStr$effDanCapStr

    echo -e $printStr
}

function runcapscan()
{
    for dir in `ls /proc`
    do
        if [ -f /proc/$dir/status ]
        then
            findCap $dir $1 $2 $3
        fi
    done
}

ifShowRoot=0
chooseCap=0
targetCap=""
while true;do
    case "$1" in
        --showroot)
            ifShowRoot=1
            shift 1;;
        -c|--cap)
            chooseCap=1
            targetCap=$2
            shift 2;;
        -h|--help)
            show_help_info
            exit 0;;
        -a|--all)
            dangerCap=$allCap
            shift 1;;
        --)
            shift ;
            break;;
        "")
            shift ;
            break ;;
        *)
            echo "$script_name: invalid param or option" '--' "\`$1'"
            echo "Try \`$script_name --help' for more information"
            exit 1;;
    esac
done
runcapscan $ifShowRoot $chooseCap $targetCap 
