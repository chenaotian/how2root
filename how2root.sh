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
    gidList=`cat /etc/group 2>/dev/null`
    if [ "$gidList" == "" ]
    then
        echo "[!] read /etc/group error"
        return 1
    fi

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

#1: user name
#echo: uid
#ret: success/fail
function uname2uid()
{
    passwd=`cat /etc/passwd 2>/dev/null`
    if [ "$passwd" == "" ]
    then
        echo "[!] read /etc/passwd error"
        return 1
    fi

    for p in ${passwd// /_}
    do
        usrName=${p%%:*}
        uuid=${p#*:}
        uuid=${uuid#*:}
        uuid=${uuid%%:*}
        if [ "$usrName" == "$1" ]
        then
            echo $uuid
            return 0
        fi
    done
    echo "[!] get uid ERROR"
    return 1
}

#1: pid
#echo:uid
function onlyGetUid()
{
    status=`cat /proc/$1/status`
    uid=${status#*Uid:}
    uid=${uid%%Gid*}
    for u in $uid
    do
        uid=$u
        break
    done
    echo $uid
}

#1: pid
#echo: user name, uid, group name, gid
#return: success 0/fail 1
function getUGid()
{
    uid=`onlyGetUid $1`

    passwd=`cat /etc/passwd 2>/dev/null`
    if [ "$passwd" == "" ]
    then
        echo "[!] read /etc/passwd error"
        return 1
    fi

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
            tmpRet=$?
            if [ $tmpRet == 1 ]
            then
                groupName="UNKNOWN"
            fi
            echo $usrName" "$uid" "$groupName" "$ggid
            return 0
        fi
    done
    echo "[!] getUGid ERROR"
    return 1
}



#1: pid
#echo: exe path or Unknown
function getExe()
{
    if [ -f /proc/$1/exe ]
    then
        exeresult=`ls -l /proc/$1/exe 2>/dev/null`
        tmpRet=$(echo $exeresult | grep "\->")
        if [ "$tmpRet" != "" ]
        then
            exe=${exeresult#*->}
        else
            exe="Unknown"
        fi
    else
        exe="Unknown"
    fi
    echo $exe
    return 0
}

#1: file path
#2: process user name
#3: file type dir or file
#return: mask value
function ifSthRight()
{
    if [ "$3" == 'file' ]
    then
        ret=`ls -l $1 2>/dev/null `
        fileOwnerName=`ls -l $1  2>/dev/null| awk '{print $3}' | head -n 1`
        fileGroupNmae=`ls -l $1  2>/dev/null| awk '{print $4}' | head -n 1`
        if [ -z "$ret" ]
        then
            echo "$1 isn't exist!"
            return 0
        fi
    elif [ "$3" == 'dir' ]
    then
        ret=`ls -al $1 | grep " \.$"| head -n 1 `       
        fileOwnerName=`ls -al $1 | grep " \.$" | awk '{print $3}' | head -n 1 `
        fileGroupNmae=`ls -al $1 | grep " \.$" | awk '{print $4}' | head -n 1`          
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

    if [ "$fileOwnerName" != "$2" -a  "$fileOwnerName" != "root" ]
    then
        result=$(($result|$fileOwnerIsntPOwner))
    fi
    return $result
}

#1: dir path
#ret: yes 0/no 1
function ifDirExist()
{
    ret=`ls -al $1 2>/dev/null`
    if [ "$ret" == "" -a $? != 0 ]
    then    
        return 1
    fi
    return 0
}

#1: dir path
#echo: exist father dir path
function getExistDir()
{
    dir=$1
    if [ ${1: 0: 1} != "/" ]
    then
        dir="/"$1
    fi
    dirFatherPath=${dir%/*}
    #echo $dirFatherPath
    ifDirExist $dirFatherPath"/"
    if [ $? == 1 ]
    then
        getExistDir $dirFatherPath
    else
        echo $dirFatherPath"/"
    fi
}

#1: dir/file path
#ret: can / cannot make
function ifCouldMade()
{
    fatherDir=`getExistDir $1`
    fatherDirInfo=`ls -al $fatherDir | grep " \.$" `
    ownRWX=${fatherDirInfo: 1: 3}
    groupRWX=${fatherDirInfo: 4: 3}
    otherRWX=${fatherDirInfo: 7: 3}

    ownUser=`ls -al $fatherDir | grep " \.$" | awk '{print $3}' | head -n 1`
    groupName=`ls -al $fatherDir | grep " \.$" | awk '{print $4}' | head -n 1`
    if [ "$ownUser" != "root" -a ${ownRWX: 1: 1} == 'w' ]
    then
        return 1
    elif [ ${otherRWX: 1: 1} == 'w' -o ${groupRWX: 1: 1} == 'w'  ]
    then
        return 1
    fi
    return 0
}

#1: dir list
#2: user name
#echo: dir path
#return: mask value
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
    #dir not exist but could be maked
    dirMakable=8

    for dir in $dirList
    do
        ifDirExist $dir
        tmpRet=$?
        #if dir not exist
        if [ $tmpRet == 1 ]
        then
            #if dir could be made
            ifCouldMade $dir            
            if [ $? == 1  ]
            then
                result=$(($result|$dirMakable))
                printStr=$printStr"$dir "
            fi
            continue
        fi

        #dir exist, if dir's rwx is right
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
#echo: env string
#ret: success 0/fail 1
function getEnvByStrings()
{
    strings=`which strings`
    if [ $? != 0 ]
    then
        echo "ERROR: there isn't strings command"
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
#echo: process capbilities information
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
        exe=`ls -l /proc/$1/exe  2>/dev/null`
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
    for dir in `ls /proc  2>/dev/null`
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
    tmpRet=$?

    usrName=${ret%% *}
    uid=${ret#*}
    groupName=${uid#* }
    gid=${groupName#* }
    uid=${uid%% *}
    groupName=${groupName%% *}
    uid=`onlyGetUid $1`

    #echo "pid is: "$1
    if [ $2 == 0 -a $(($uid)) != 0 ]
    then 
        #echo "pid is: "$1
        return
    fi

    printStr="-----------------------------------------------------\n[+] PID: $1\n[+] UID: $uid $usrName\n[+] EXE: "
    exe=`getExe $1` 
    exeInfo=`ls -l $exe 2>/dev/null`

    #echo $exe,$1,$exeInfo

    #check exe file-------------------------------------
    otherWritable=1
    groupWritable=2
    ownerIsntPUser=4
    dirMakable=8
    #/proc/pid/exe not exist,
    if [ $exe == "Unknown" ]
    then
        tmpRet=0
    elif [ "$exeInfo" == "" ]  #/proc/pid/exe exist but real exe not exist
    then
        #if real exe's dir have x, that if real exe may be made
        ifCouldMade $exe            
        if [ $? == 1  ]
        then
            tmpRet=8
            ifPrint=1
        fi
    else
        ifSthRight $exe $usrName file
        tmpRet=$?
    fi

    #if real exe not exist, ls -al not have print
    if [ $tmpRet != 0 -a $tmpRet != 8 ]
    then
        ifPrint=1
        exe=`ls -al $exe 2>/dev/null`
    fi
    printStr=$printStr$exe"\n"

    if [ $tmpRet != 0 ]
    then
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
        if [ $(($tmpRet&$dirMakable)) != 0 ]
        then
            printStr=$printStr"\t[-] Exe not exisst but could be made!\n"
        fi   
    fi

    #check env LD_LIBRARY_PATH ----------------------------------------
    dirOtherUserWriteable=0
    dirGroupUserWriteable=0
    dirUserNotSame=0
    dirStr=""

    env=`getEnvByStrings $1 LD_LIBRARY_PATH`
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
            if [ $(($tmpRet&$dirMakable)) != 0 ]
            then
                printStr=$printStr"\t[-] Dir not exisst but could be made!\n"
            fi            
        fi
    fi

    #final echo------------------------------------------------
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
            if [ $(($dir)) == $2  -o $2 == 0 ] 
            then
                rootProcess $dir $1 
            fi
        fi
    done
}

ifShowAll=0
chooseCap=0
processRoot=0
noDetail=0
processCap=0
targetCap=""
oneProcess=0
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
        -p)  #only for test
            oneProcess=$2
            shift 2;;
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
    searchRootProcess $ifShowAll  $oneProcess
    exit 0
elif [ $processCap == 1 ]
then
    runcapscan $ifShowAll $chooseCap $targetCap 
    exit 0
else
    runcapscan $ifShowAll $chooseCap $targetCap 
    searchRootProcess $ifShowAll  $oneProcess
fi



