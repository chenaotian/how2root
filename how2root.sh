#!/bin/bash
#chenaotian
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
    -h, --help      Show help information

        --showall   Search all process
                    Default show thread that uid not 0
    --------------------------------------------------------------------------------------------------
        --pr        Search root process's exe, env(LD_LIBRARY_PATH)
                        If other user can write them
                        If the same group user can write them
                        If the file/dir user is different from the process

    -d,--nodetail   Don't show more detail information
                    Now detail information only "If a env dir not exist"
    --------------------------------------------------------------------------------------------------
        --pc        Search progress capbilities which is not root
                    Default mode only search thread with danger capbilities like these:
                        CAP_CHOWN CAP_DAC_OVERRIDE CAP_DAC_READ_SEARCH CAP_FOWNER CAP_SETGID 
                        CAP_SETUID CAP_NET_ADMIN CAP_IPC_OWNER CAP_SYS_MODULE CAP_SYS_PTRACE CAP_SETFCAP
                    You can use -c,--cap to choose capbilities

    -c, --cap       Only search thread with capbilities that you specified
                    Only uppercase capbilities is supported

    -a, --all       Show thread with any capbility
EOF
}

#1: gid
function getGroupName()
{
    gidList=`cat /etc/group`
    for g in ${gidList// /_}
    do
        groupName=${g%%:*}
        ggid=${g#*:}
        ggid=${ggid#*:}
        ggid=${ggid%%:*}
        if [ $(($1)) == $ggid ]
        then
            echo $groupName
            return 0
        fi
    done
    echo "[!] getGroupName ERROR"
    return 1
}

#1: pid
function getUGid()
{
    status=`cat /proc/$1/status`
    uid=${status#*Uid:}
    uid=${uid%%Gid*}
    for u in $uid
    do
        uid=$u
        break
    done

    passwd=`cat /etc/passwd`
    for p in ${passwd// /_}
    do
        usrName=${p%%:*}
        uuid=${p#*:}
        uuid=${uuid#*:}
        ggid=${uuid#*:}
        uuid=${uuid%%:*}
        ggid=${ggid%%:*}
        if [ $uuid == $uid ]
        then
            groupName=`getGroupName $ggid`
            echo $usrName" "$uid" "$groupName" "$ggid
            return 0
        fi
    done
    echo "[!] getUGid ERROR"
    return 1
}

#1: pid
function getExe()
{
    if [ -f /proc/$1/exe ]
    then
        exe=`ls -l /proc/$1/exe`
        exe=${exe#*->}
    else
        exeLine="Unknown"
    fi
    echo $exe
    return 0
}

#1: file path
#2: process user name
#3: file type dir or file
function ifSthRight()
{
    if [ $3 == 'file' ]
    then
        ret=`ls -l $1`
        fileOwnerName=`ls -l $1 | awk '{print $3}'`
        fileGroupNmae=`ls -l $1 | awk '{print $4}'`
        if [ -z "$ret" ]
        then
            echo "$1 isn't exist!"
            return 0
        fi
    elif [ $3 == 'dir' ]
    then       
        if [ ${1: -1: 1} == '/' ]
        then            
            dirPath=${1: 0: ${#1}-1}
            
        else
            dirPath=$1
        fi
        dirName=${dirPath##*/}
        dirFatherPath=${dirPath%/*}"/"
        ret=`ls -l $dirFatherPath | grep " $dirName$"`
        fileOwnerName=`ls -l $dirFatherPath | grep " $dirName$" | awk '{print $3}' `
        fileGroupNmae=`ls -l $dirFatherPath | grep " $dirName$" | awk '{print $4}'`  
        if [ -z "$ret" ]
        then
            echo "$1 dir isn't exist!"
            return 0
        fi
    fi

    thisType=${ret: 0: 1}
    ownRWX=${ret: 1: 3}
    groupRWX=${ret: 4: 3}
    otherRWX=${ret: 7: 3}
    #echo "bbb"$1,$thisType,$ownRWX,$groupRWX,$otherRWX

    #other user can write
    otherWritable=1 
    #same group user can write
    groupWritable=2
    #file owner isn't the process user
    fileOwnerIsntPOwner=4

    result=0

    if [[ ${otherRWX: 1: 1} == 'w' ]]
    then
        result=$(($result|$otherWritable))
    fi

    if [[ ${groupRWX: 1: 1} == 'w' ]]
    then
        result=$(($result|$groupWritable))
    fi

    if [[ $fileOwnerName != $2 ]]
    then
        result=$(($result|$fileOwnerIsntPOwner))
    fi
    return $result
}

#1: dir list
#2: user name
function someDirCheck()
{
    result=0
    usrName=$2
    dirList=$1
    printStr=""
    #other user can write
    dirOtherUserWriteable=1 
    #same group user can write
    dirGroupUserWriteable=2
    #file owner isn't the process user
    dirOwnerIsntPUser=4

    for dir in $dirList
    do
        ifSthRight $dir $usrName dir
        tmpRet=$?
        if [ $tmpRet == 0 ]
        then
            continue
        fi

        printStr=$printStr"$dir "
        if [ $(($tmpRet&$dirOtherUserWriteable)) != 0 ]
        then
            result=$(($result|$dirOtherUserWriteable))
        fi

        if [ $(($tmpRet&$dirGroupUserWriteable)) != 0 ]
        then
            result=$(($result|$dirGroupUserWriteable))
        fi

        if [ $(($tmpRet&$dirOwnerIsntPUser)) != 0 ]
        then
            result=$(($result|$dirOwnerIsntPUser))
        fi
    done

    echo -e $printStr
    return $result
}

#1: pid
#2: env word
function getEnvByStrings()
{
    strings=`which strings`
    if [ $? != 0 ]
    then
        echo "ERROR: there isn't strings"
        return 1
    fi

    env=`strings /proc/$1/environ | grep $2`
    if [ ${#env} == 0 ]
    then
        echo "NOTHING"
        return 1
    fi

    env=${env#*=}
    env=${env// /_}
    env=${env//:/ }
    echo $env
    return 0
}

#1: pid
#2: ifShowAll
#3: ifChooseCap
#4: targetCap
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
        exe=`ls -l /proc/$1/exe`
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

#1: ifShowAll
#2: ifChooseCap
#3: targetCap
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

#1: pid
#2: ifShowAll
function rootProcess()
{
    ifPrint=0
    ret=`getUGid $1`
    usrName=${ret%% *}
    uid=${ret#* }
    groupName=${uid#* }
    gid=${groupName#* }
    uid=${uid%% *}
    groupName=${groupName%% *}

    #echo "pid is: "$1
    if [ $2 == 0 -a $(($uid)) != 0 ]
    then 
        #echo "pid is: "$1
        return
    fi

    printStr="-----------------------------------------------------\n[+] PID: $1\n[+] UID: $uid $usrName\n[+] EXE: "
    exe=`getExe $1` 
    #echo $exe

    #check exe file
    otherWritable=1
    groupWritable=2
    ownerIsntPUser=4
    ifSthRight $exe $usrName file
    tmpRet=$?
    if [ $tmpRet != 0 ]
    then
        ifPrint=1
        exe=`ls -al $exe`
    fi
    printStr=$printStr$exe"\n"

    if [ $(($tmpRet&$otherWritable)) != 0 ]
    then
        printStr=$printStr"\t[-] Other user can write this EXE!\n"
    fi
    if [ $(($tmpRet&$groupWritable)) != 0 ]
    then
        printStr=$printStr"\t[-] Same group user can write this EXE!\n"
    fi
    if [ $(($tmpRet&$ownerIsntPUser)) != 0 ]
    then
        printStr=$printStr"\t[-] Different user between file and process!\n"
    fi

    #check env LD_LIBRARY_PATH
    dirOtherUserWriteable=0
    dirGroupUserWriteable=0
    dirUserNotSame=0
    dirStr=""

    env=`getEnvByStrings $1 PATH`
    #echo $env
    if [ $? == 1 ]
    then
        printStr=$printStr"[+] ENV: $env\n"
    else
        dirStr=`someDirCheck "$env" $usrName`
        tmpRet=$?
        if [ $tmpRet != 0 ]
        then
            printStr=$printStr"[+] ENV: $dirStr\n"
            ifPrint=1

            if [ $(($tmpRet&$otherWritable)) != 0 ]
            then
                printStr=$printStr"\t[-] Other user can write any env dir!\n"
            fi
            if [ $(($tmpRet&$groupWritable)) != 0 ]
            then
                printStr=$printStr"\t[-] Same group user can write any env dir!\n"
            fi
            if [ $(($tmpRet&$ownerIsntPUser)) != 0 ]
            then
                printStr=$printStr"\t[-] Different user between any env dir's user and this process user!\n"
            fi
        else
            if [ -n "$printStr" -a $3 == 0 ]
            then
                ifPrint=1
                printStr=$printStr"[+] ENV: $dirStr\n"
            fi
        fi
    fi



    if [ $ifPrint != 0 ]
    then
        echo -e $printStr
    fi


}

function searchRootProcess()
{
    for dir in `ls /proc`
    do
        if [ -f /proc/$dir/status ]
        then
            rootProcess $dir $1 $2
        fi
    done
}

ifShowAll=0
chooseCap=0
processRoot=0
noDetail=0
processCap=0
targetCap=""
while true;do
    case "$1" in
        --showall)
            ifShowAll=1
            shift 1;;
        -c|--cap)
            chooseCap=1
            targetCap=$2
            shift 2;;
        -h|--help)
            show_help_info
            exit 0;;
        -a|--allcap)
            dangerCap=$allCap
            shift 1;;
        --pr)
            processRoot=1
            shift 1;;   
        --pc)
            processCap=1
            shift 1;;
        -d|--nodetail)
            noDetail=1
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
if [ $processRoot == 1 ]
then
    searchRootProcess $ifShowAll $noDetail
    exit 0
elif [ $processCap == 1 ]
then
    runcapscan $ifShowAll $chooseCap $targetCap 
    exit 0
else
    runcapscan $ifShowAll $chooseCap $targetCap 
    searchRootProcess $ifShowAll $noDetail
fi



