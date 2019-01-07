#!/bin/sh
#
# TODO: Add ON DUPLICATE KEY (IGNORE)
#

OUTPUT_FOLDER=poor_mans_os_query
if [ -z HOSTNAME ]; then
    declare -r HOSTNAME
    HOSTNAME=`uname -n || hostname || cat /etc/hostname`
fi
mkdir -p ${OUTPUT_FOLDER}

declare -i SELINUX_ENABLED
which selinuxenabled > /dev/null
if [ $? -eq 0 ]; then
    selinuxenabled
fi
if [ $? -eq 0 ]; then
    SELINUX_ENABLED=1
else
    SELINUX_ENABLED=0
fi

#
# Host
#

declare -r DISTRO_RELEASE
DISTRO_RELEASE = || \
    cat /etc/SuSE-release || \
    cat /etc/redhat-release || \
    cat /etc/redhat_version || \
    cat /etc/fedora-release || \
    cat /etc/slackware-release || \
    cat /etc/slackware-version || \
    cat /etc/debian_release || \
    cat /etc/debian_version || \
    cat /etc/os-release || \
    cat /etc/mandrake-release || \
    cat /etc/yellowdog-release || \
    cat /etc/sun-release || \
    cat /etc/release || \
    cat /etc/gentoo-release || \
    lsb_release -d || \
    echo NULL

OUTPUT_FILE=${OUTPUT_FOLDER}/host.sql
>${OUTPUT_FILE}
echo "INSERT INTO Hosts SET " >> ${OUTPUT_FILE}
echo "hostname                        = '${HOSTNAME}'," >> ${OUTPUT_FILE}
echo "kernelName                      = '$(uname -s)'," >> ${OUTPUT_FILE}
echo "releaseVersion                  = '$(uname -r)'," >> ${OUTPUT_FILE}
echo "architecture                    = '$(uname -m)'," >> ${OUTPUT_FILE}
echo "processorType                   = '$(uname -p)'," >> ${OUTPUT_FILE}
echo "hardwarePlatform                = '$(uname -i)'," >> ${OUTPUT_FILE}
echo "operatingSystem                 = '$(uname -o)'," >> ${OUTPUT_FILE}
echo "distroRelease                   = '${DISTRO_RELEASE}'," >> ${OUTPUT_FILE}

which dmidecode > /dev/null
if [ $? -eq 0 ]; then
    echo "biosVendor                      = '$(dmidecode --string bios-vendor)'," >> ${OUTPUT_FILE}
    echo "biosVersion                     = '$(dmidecode --string bios-version)'," >> ${OUTPUT_FILE}
    echo "biosReleaseDate                 = STR_TO_DATE('$(dmidecode --string bios-release-date)', '%m/%d/%Y')," >> ${OUTPUT_FILE}
    echo "biosMemoryAddress               = CAST($(dmidecode --type 0 | grep Address | sed -r 's/.*: (.*)/\1/g') AS INTEGER UNSIGNED)," >> ${OUTPUT_FILE}
    echo "biosRuntimeSize                 = $(dmidecode --type 0 | grep 'Runtime Size' | sed -r 's/.*: (.*) kB/\1/g')," >> ${OUTPUT_FILE}
    echo "biosROMSize                     = $(dmidecode --type 0 | grep 'ROM Size' | sed -r 's/.*: (.*) kB/\1/g')," >> ${OUTPUT_FILE}
    # echo "isaSupported                    = $(dmidecode --type 0 : Characteristics : ISA is supported)" >> ${OUTPUT_FILE}
    # echo "pciSupported                    = $(dmidecode --type 0 : Characteristics : PCI is supported)" >> ${OUTPUT_FILE}
    # echo "bootFromCDSupported             = $(dmidecode --type 0 : Characteristics : Boot from CD is supported)" >> ${OUTPUT_FILE}
    # echo "selectableBootSupported         = $(dmidecode --type 0 : Characteristics : Selectable boot is supported)" >> ${OUTPUT_FILE}
    # echo "keyboard8042ServicesSupported   = $(dmidecode --type 0 : Characteristics : 8042 keyboard services are supported (int 9h))" >> ${OUTPUT_FILE}
    # echo "cgaMonoVideoServicesSupported   = $(dmidecode --type 0 : Characteristics : CGA/mono video services are supported (int 10h))" >> ${OUTPUT_FILE}
    # echo "acpiSupported                   = $(dmidecode --type 0 : Characteristics : ACPI is supported)" >> ${OUTPUT_FILE}
    echo "systemManufacturer              = '$(dmidecode --string system-manufacturer)'," >> ${OUTPUT_FILE}
    echo "systemProductName               = '$(dmidecode --string system-product-name)'," >> ${OUTPUT_FILE}
    echo "systemVersion                   = '$(dmidecode --string system-version)'," >> ${OUTPUT_FILE}
    echo "systemSerialNumber              = '$(dmidecode --string system-serial-number)'," >> ${OUTPUT_FILE}
    echo "systemUUID                      = '$(dmidecode --string system-uuid)'," >> ${OUTPUT_FILE}
    echo "systemWakeUpType                = '$(dmidecode --type 1 | grep 'Wake-up Type' | sed -r 's/.*: (.*)/\1/g')'," >> ${OUTPUT_FILE}
    echo "systemSKUNumber                 = '$(dmidecode --type 1 | grep 'SKU Number' | sed -r 's/.*: (.*)/\1/g')'," >> ${OUTPUT_FILE}
    echo "systemFamily                    = '$(dmidecode --type 1 | grep 'Family' | sed -r 's/.*: (.*)/\1/g')'," >> ${OUTPUT_FILE}
    echo "baseboardManufacturer           = '$(dmidecode --string baseboard-manufacturer)'," >> ${OUTPUT_FILE}
    echo "baseboardProductName            = '$(dmidecode --string baseboard-product-name)'," >> ${OUTPUT_FILE}
    echo "baseboardVersion                = '$(dmidecode --string baseboard-version)'," >> ${OUTPUT_FILE}
    echo "baseboardSerialNumber           = '$(dmidecode --string baseboard-serial-number)'," >> ${OUTPUT_FILE}
    echo "baseboardAssetTag               = '$(dmidecode --string baseboard-asset-tag)'," >> ${OUTPUT_FILE}
    # echo "hostingBoard                    = $(dmidecode --type 2 : Board is a hosting board)" >> ${OUTPUT_FILE}
    echo "locationInChassis               = '$(dmidecode --type 2 | grep 'Location In Chassis' | sed -r 's/.*: (.*)/\1/g')'," >> ${OUTPUT_FILE}
    echo "chassisHandle                   = CAST($(dmidecode --type 2 | grep 'Chassis Handle' | sed -r 's/.*: (.*)/\1/g') AS INTEGER UNSIGNED)," >> ${OUTPUT_FILE}
    echo "baseboardType                   = '$(dmidecode --type 2 | grep 'Type' | sed -r 's/.*: (.*)/\1/g')'," >> ${OUTPUT_FILE}
    echo "chassisManufacturer             = '$(dmidecode --string chassis-manufacturer)'," >> ${OUTPUT_FILE}
    echo "chassisType                     = '$(dmidecode --string chassis-type)'," >> ${OUTPUT_FILE}
    echo "chassisLock                     = '$(dmidecode --type 2 | grep 'Type' | sed -r 's/.*: (.*)/\1/g')'," >> ${OUTPUT_FILE}
    echo "chassisVersion                  = '$(dmidecode --string chassis-version)'," >> ${OUTPUT_FILE}
    echo "chassisSerialNumber             = '$(dmidecode --string chassis-serial-number)'," >> ${OUTPUT_FILE}
    echo "chassisAssetTag                 = '$(dmidecode --string chassis-asset-tag)'," >> ${OUTPUT_FILE}
    echo "chassisBootUpState              = '$(dmidecode --type 3 | grep 'Boot-up State' | sed -r 's/.*: (.*)/\1/g')'," >> ${OUTPUT_FILE}
    echo "chassisPowerSupplyState         = '$(dmidecode --type 3 | grep 'Power Supply State' | sed -r 's/.*: (.*)/\1/g')'," >> ${OUTPUT_FILE}
    echo "chassisThermalState             = '$(dmidecode --type 3 | grep 'Thermal State' | sed -r 's/.*: (.*)/\1/g')'," >> ${OUTPUT_FILE}
    echo "chassisSecurityStatus           = '$(dmidecode --type 3 | grep 'Security Status' | sed -r 's/.*: (.*)/\1/g')'," >> ${OUTPUT_FILE}
fi

echo "uptimeInSeconds                 = $(cat /proc/uptime | sed -r "s/^([[:digit:]]+)\..*/\1/g" )" >> ${OUTPUT_FILE}
echo ";" >> ${OUTPUT_FILE}
echo "SET @currenthost = LAST_INSERT_ID();" >> ${OUTPUT_FILE}

#
# RPM Packages
# See this: http://rpm.org/user_doc/query_format.html
#

OUTPUT_FILE=${OUTPUT_FOLDER}/rpms.sql
>${OUTPUT_FILE}
echo "INSERT INTO InstalledRPMPackages (hostnameID, name, version, releaseTag, epoch, summary, description, buildtime, buildhost, installtime, longarchivesize, longfilesizes, longsigsize, size) VALUES " >> ${OUTPUT_FILE}
rpm -qa --queryformat "\t(@currenthost, -|_%{name}-|_, -|_%{version}-|_, -|_%{release}-|_, -|_%{epoch}-|_, -|_%{summary}-|_, -|_%{description}-|_, FROM_UNIXTIME(%{buildtime}), -|_%{buildhost}-|_, FROM_UNIXTIME(%{installtime}), %{longarchivesize}, %{longfilesizes}, %{longsigsize}, %{longsize}),\n" >> ${OUTPUT_FILE}
sed -i "s/'/''/g" ${OUTPUT_FILE} # This doubles up the single quotes
sed -i "s/\-|_/'/g" ${OUTPUT_FILE} # This converts the -|_ to single quotes
sed -i '$ s/.$//' ${OUTPUT_FILE} # This removes the trailing newline and comma
sed -i "s/'(none)'/NULL/g" ${OUTPUT_FILE}
sed -i "s/(none)/NULL/g" ${OUTPUT_FILE}
echo ";" >> ${OUTPUT_FILE}

#
# Files
#

OUTPUT_FILE=${OUTPUT_FOLDER}/files.sql
>${OUTPUT_FILE}
echo "INSERT INTO Files (hostnameID, directory, fileName, inodeNumber, depth, userID, groupID, lastAccessTime, lastModifyTime, creationTime, sizeInBytes, deviceNumber, fileSystemType, objectOfSymbolicLink, fileType, mode, selinuxContext) VALUES " >> ${OUTPUT_FILE}

if [ ${SELINUX_ENABLED} == 1 ]; then # If SELinux is enabled
    find / \( -path /proc -o -path /sys -o -path /vagrant \) -prune -o -type f -printf "\t(@currenthost, '%h', '%f', %i, %d, %U, %G, FROM_UNIXTIME(%A@), FROM_UNIXTIME(%T@), FROM_UNIXTIME(%C@), %s, %D, '%F', '%l', '%y', '%m', '%Z'),\n" >> ${OUTPUT_FILE}
else
    find / \( -path /proc -o -path /sys -o -path /vagrant \) -prune -o -type f -printf "\t(@currenthost, '%h', '%f', %i, %d, %U, %G, FROM_UNIXTIME(%A@), FROM_UNIXTIME(%T@), FROM_UNIXTIME(%C@), %s, %D, '%F', '%l', '%y', '%m', NULL),\n" >> ${OUTPUT_FILE}
fi
sed -i '$ s/.$//' ${OUTPUT_FILE} # This removes the trailing newline and comma
echo ";" >> ${OUTPUT_FILE}

#
# Environment Variables
#

OUTPUT_FILE=${OUTPUT_FOLDER}/env.sql
>${OUTPUT_FILE}
echo "INSERT INTO EnvironmentVariables (hostnameID, variableName, variableValue) VALUES " >> ${OUTPUT_FILE}
env | sed "s/'/''/g" | sed -r "s/^([^=]+)=(.*)/\t(@currenthost, '\\1', '\\2'),/g" >> ${OUTPUT_FILE}
sed -i '$ s/.$//' ${OUTPUT_FILE} # This removes the trailing newline and comma
echo ";" >> ${OUTPUT_FILE}

#
# CPUs
#

OUTPUT_FILE=${OUTPUT_FOLDER}/cpus.sql
>${OUTPUT_FILE}
echo "INSERT INTO EnvironmentVariables VALUES SET " >> ${OUTPUT_FILE}
cat /proc/cpuinfo | \
    sed 's/:/=/g' | \
    sed 's/$/,/g' | \
    sed 's/= yes/= TRUE/g' | \
    sed 's/= no/= FALSE/g' | \
    tr '\n' '\r' | \
    sed 's/\r,\r/\r\rINSERT INTO CentralProcessingUnits VALUES SET\rhostID\t\t= @currenthost,\r/g' | \
    tr '\r' '\n' | \
    sed 's/^processor[[:space:]]\+/processorNumber\t/g' | \
    sed -r "s/^vendor_id[[:space:]]+= (.*),/vendorID\t= '\1',/g" | \
    sed 's/^cpu family[[:space:]]\+=/cpuFamily\t=/g' | \
    sed -r "s/^model name[[:space:]]+= (.*),/modelName\t= '\1',/g" | \
    sed 's/^cpu MHZ[[:space:]]\+=/cpuMegahertz\t=/g' | \
    sed -r "s/^cache size[[:space:]]+= (.*) KB,/cacheSizeInKilobytes\t= \1,/g" | \
    sed 's/^physical id[[:space:]]\+=/physicalID\t=/g' | \
    sed 's/^core id[[:space:]]\+=/coreID\t\t=/g' | \
    sed 's/^cpu cores[[:space:]]\+=/cpuCores\t=/g' | \
    sed 's/^apicid[[:space:]]\+=/apicID\t\t=/g' | \
    sed 's/^initial apicid[[:space:]]\+=/initialAPICID\t=/g' | \
    sed 's/^fpu[[:space:]]\+=/hasFloatingPointUnit\t=/g' | \
    sed 's/^fpu_exception[[:space:]]\+=/floatingPointUnitException\t=/g' | \
    sed 's/^cpuid level[[:space:]]\+=/cpuidLevel\t=/g' | \
    sed 's/^bogomips[[:space:]]\+=/bogoMIPS\t=/g' | \
    sed 's/^clflush size[[:space:]]\+=/cacheLineFlushSize\t=/g' | \
    sed 's/^cache_alignment[[:space:]]\+=/cacheAlignment\t=/g' | \
    sed -r "s/^address sizes[[:space:]]+= ([[:digit:]]+) bits physical, ([[:digit:]]+) bits virtual/physicalAddressSize\t= \1,\nvirtualAddressSize\t= \2/g" | \
    sed 's/^power management=,/--power management/g' | \
    sed 's/^flags/--flags/g' | \
    sed 's/^bugs/--bugs/g' >> ${OUTPUT_FILE}
head -n -2 ${OUTPUT_FILE}

# fpu
# vme
# de
# pse
# tsc
# msr
# pae
# mce
# cx8
# apic
# sep
# mtrr
# pge
# mca
# cmov
# pat
# pse36
# pn
# clflush
# ds
# acpi
# mmx
# fxsr
# xmm
# xmm2
# selfsnoop
# ht
# acc
# ia64
# pbe
# syscall
# mp
# nx
# mmxext
# fxsr_opt
# gbpages
# rdtscp
# lm
# 3dnowext
# 3dnow
# recovery
# longrun
# lrti
# cxmmx
# k6_mtrr
# cyrix_arr
# centaur_mcr
# k8
# k7
# p3
# p4
# constant_tsc
# up
# art
# arch_perfmon
# pebs
# bts
# syscall32
# sysenter32
# rep_good
# mfence_rdtsc
# lfence_rdtsc
# acc_power
# nopl
# always
# xtopology
# tsc_reliable
# nonstop_tsc
# extd_apicid
# amd_dcm
# aperfmperf
# eager_fpu
# nonstop_tsc_s3
# xmm3
# pclmulqdq
# dtes64
# mwait
# dscpl
# vmx
# smx
# est
# tm2
# ssse3
# cid
# sdbg
# fma
# cx16
# xtpr
# pdcm
# pcid
# dca
# xmm4_1
# xmm4_2
# x2apic
# movbe
# popcnt
# tsc_deadline_timer
# aes
# xsave
# osxsave
# avx
# f16c
# rdrand
# hypervisor
# xstore
# xstore_en
# xcrypt
# xcrypt_en
# ace2
# ace2_en
# phe
# phe_en
# pmm
# pmm_en
# lahf_lm
# cmp_legacy
# svm
# extapic
# cr8_legacy
# abm
# sse4a
# misalignsse
# 3dnowprefetch
# osvw
# ibs
# xop
# skinit
# wdt
# lwp
# fma4
# tce
# nodeid_msr
# tbm
# topoext
# perfctr_core
# perfctr_nb
# bpext
# ptsc
# perfctr_l2
# mwaitx
# cpb
# epb
# hw_pstate
# proc_feedback
# intel_pt
# avx512_4vnniw
# avx512_4fmaps
# tpr_shadow
# vnmi
# flexpriority
# ept
# vpid
# vmmcall
# xenpv
# fsgsbase
# tsc_adjust
# bmi1
# hle
# avx2
# smep
# bmi2
# erms
# invpcid
# rtm
# cqm
# mpx
# avx512f
# avx512dq
# rdseed
# adx
# smap
# clflushopt
# clwb
# avx512pf
# avx512er
# avx512cd
# sha_ni
# avx512bw
# avx512vl
# xsaveopt
# xsavec
# xgetbv1
# xsaves
# cqm_llc
# cqm_occup_llc
# cqm_mbm_total
# cqm_mbm_local
# clzero
# irperf
# dtherm
# ida
# arat
# pln
# pts
# hwp
# hwp_notify
# hwp_act_window
# hwp_epp
# hwp_pkg_req
# npt
# lbrv
# svml
# nrips
# tscratemsr
# vmcbclean
# flushbyasid
# decodeassists
# pausefilter
# pfthreshold
# avic
# pku
# ospke
# overflow_recov
# succor
# smca

# f00f
# fdiv
# coma
# amd_tlb_mmatch
# amd_apic_c1e
# 11ap
# fxsave_leak
# clflush_monitor
# sysret_ss_attrs
# espfix
# null_seg
# swapgs_fence
# monitor
# cpu_meltdown
# spectre_v1
# spectre_v2

#
# Yum Repositories
#

which yum > /dev/null
if [ $? -eq 0 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/yumrepos.sql
    >${OUTPUT_FILE}
    for filename in /etc/yum.repos.d/*.repo; do
        cat $filename | \
        sed -e '$a\\' | \
        sed 's/^\s*#/-- #/g' | \
        sed -r "s/\[(.*)\]/INSERT INTO YumRepositories SET\nslug = '\1',/g" | \
        sed -r "s/^\s*name=(.*)/name = '\1',/g" | \
        sed -r "s/^\s*baseurl=(.*)/baseURI = '\1',/g" | \
        sed -r "s/^\s*metalink=(.*)/metalinkURI = '\1',/g" | \
        sed -r "s/^\s*mirrorlist=(.*)/mirrorlistURI = '\1',/g" | \
        sed -r "s/^\s*enabled=(.*)/enabled = \1,/g" | \
        sed -r "s/^\s*gpgcheck=(.*)/checkGPGSignatureOnPackages = \1,/g" | \
        sed -r "s/^\s*repo_gpgcheck=(.*)/checkGPGSignatureOnRepoMetadata = \1,/g" | \
        sed -r "s/^\s*gpgkey=(.*)/gpgKeyURI = '\1',/g" | \
        sed -r "s/^\s*gpgcakey=(.*)/gpgCAKeyURI = '\1',/g" | \
        sed -r "s/^\s*exclude=(.*)/excludePackages = '\1',/g" | \
        sed -r "s/^\s*include=(.*)/includePackages = '\1',/g" | \
        sed -r "s/^\s*enablegroups=(.*)/enablePackageGroups = \1,/g" | \
        sed -r "s/^\s*failovermethod=(.*)/failoverMethod = '\1',/g" | \
        sed -r "s/^\s*keepalive=(.*)/keepAlive = \1,/g" | \
        sed -r "s/^\s*timeout=(.*)/timeoutInSeconds = \1,/g" | \
        sed -r "s/^\s*http_caching=(.*)/httpCachingEnabled = \1,/g" | \
        sed -r "s/^\s*retries=(.*)/retries = \1,/g" | \
        sed -r "s/^\s*throttle=(.*)/throttlingBandwidth = '\1',/g" | \
        sed -r "s/^\s*bandwidth=(.*)/totalBandwidth = '\1',/g" | \
        sed -r "s/^\s*sslcacert=(.*)/tlsCACertificateURI = '\1',/g" | \
        sed -r "s/^\s*sslverify=(.*)/tlsVerificationEnabled = \1,/g" | \
        sed -r "s/^\s*sslclientcert=(.*)/tlsClientCertificateURI = '\1',/g" | \
        sed -r "s/^\s*sslclientkey=(.*)/tlsClientKeyURI = '\1',/g" | \
        sed -r "s/^\s*ssl_check_cert_permissions=(.*)/checkTLSCertificatePermissions = \1,/g" | \
        sed -r "s/^\s*metadata_expire=(.*)/metadataExpiration = '\1',/g" | \
        sed -r "s/^\s*mirrorlist_expire=(.*)/mirrorlistExpiration = '\1',/g" | \
        sed -r "s/^\s*proxy=(.*)/proxyURI = '\1',/g" | \
        sed -r "s/^\s*proxy_username=(.*)/proxyUsername = '\1',/g" | \
        sed -r "s/^\s*proxy_password=(.*)/proxyPassword = '\1',/g" | \
        sed -r "s/^\s*username=(.*)/username = '\1',/g" | \
        sed -r "s/^\s*password=(.*)/password = '\1',/g" | \
        sed -r "s/^\s*cost=(.*)/cost = \1,/g" | \
        sed -r "s/^\s*skip_if_unavailable=(.*)/skipIfUnavailable = \1,/g" | \
        sed -r "s/^\s*type=(.*)/repoType = '\1',/g" | \
        sed '/^\s*enabled_metadata.*/d' | \
        sed 's/^\s*$/hostID = @currenthost\n;\n/g' | \
        sed 's/= False,/= 0,/g' | \
        sed 's/= True,/= 1,/g' >> ${OUTPUT_FILE}
    done
fi

#
# Block Devices
#
# REVIEW: Does partitionType and partitionFlags below need to start with 0x?
#

which lsblk > /dev/null
if [ $? -eq 0 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/blockdevices.sql
    >${OUTPUT_FILE}
    lsblk -aOP | \
    sed "s/^/INSERT INTO BlockDevices SET /g" | \
    sed -r "s/ NAME=\"([^\"]*)\"/ name = '\1',/g" | \
    sed -r "s/ KNAME=\"([^\"]*)\"/ kname = '\1',/g" | \
    sed -r "s/ MAJ:MIN=\"([[:digit:]]+):([[:digit:]]+)\"/ majorNumber = \1, minorNumber = \2,/g" | \
    sed -r "s/ FSTYPE=\"([^\"]*)\"/ fileSystemType = '\1',/g" | \
    sed -r "s/ MOUNTPOINT=\"([^\"]*)\"/ mountPoint = '\1',/g" | \
    sed -r "s/ LABEL=\"([^\"]*)\"/ label = '\1',/g" | \
    sed -r "s/ UUID=\"([^\"]*)\"/ uuid = '\1',/g" | \
    sed -r "s/ PARTTYPE=\"\"//g" | \
    sed -r "s/ PARTTYPE=\"([^\"]*)\"/ partitionType = CAST(0x\1 AS UNSIGNED INTEGER),/g" | \
    sed -r "s/ PARTLABEL=\"([^\"]*)\"/ partitionLabel = '\1',/g" | \
    sed -r "s/ PARTUUID=\"([^\"]*)\"/ partitionUUID = '\1',/g" | \
    sed -r "s/ PARTFLAGS=\"\"//g" | \
    sed -r "s/ PARTFLAGS=\"([^\"]*)\"/ partitionFlags = CAST(0x\1 AS UNSIGNED INTEGER),/g" | \
    sed -r "s/ RA=\"([^\"]*)\"/ readAhead = \1,/g" | \
    sed -r "s/ RO=\"([^\"]*)\"/ readOnly = \1,/g" | \
    sed -r "s/ RM=\"([^\"]*)\"/ removable = \1,/g" | \
    sed -r "s/ HOTPLUG=\"([^\"]*)\"/ hotpluggable = \1,/g" | \
    sed -r "s/ MODEL=\"([^\"]*)\"/ model = '\1',/g" | \
    sed -r "s/ SERIAL=\"([^\"]*)\"/ serialNumber = '\1',/g" | \
    sed -r "s/ SIZE=\"([^\"]*)\"/ size = '\1',/g" | \
    sed -r "s/ STATE=\"([^\"]*)\"/ state = '\1',/g" | \
    sed -r "s/ OWNER=\"([^\"]*)\"/ ownerName = '\1',/g" | \
    sed -r "s/ GROUP=\"([^\"]*)\"/ groupName = '\1',/g" | \
    sed -r "s/ MODE=\"([^\"]*)\"/ mode = '\1',/g" | \
    sed -r "s/ ALIGNMENT=\"([^\"]*)\"/ alignment = \1,/g" | \
    sed -r "s/ MIN-IO=\"([^\"]*)\"/ minimumIOSize = \1,/g" | \
    sed -r "s/ OPT-IO=\"([^\"]*)\"/ optimumIOSize = \1,/g" | \
    sed -r "s/ PHY-SEC=\"([^\"]*)\"/ physicalSectorSize = \1,/g" | \
    sed -r "s/ LOG-SEC=\"([^\"]*)\"/ logicalSectorSize = \1,/g" | \
    sed -r "s/ ROTA=\"([^\"]*)\"/ rotationalDevice = \1,/g" | \
    sed -r "s/ SCHED=\"([^\"]*)\"/ ioSchedulerName = '\1',/g" | \
    sed -r "s/ RQ-SIZE=\"([^\"]*)\"/ requestQueueSize = \1,/g" | \
    sed -r "s/ TYPE=\"([^\"]*)\"/ deviceType = '\1',/g" | \
    sed -r "s/ DISC-ALN=\"([^\"]*)\"/ discardAlignmentOffset = '\1',/g" | \
    sed -r "s/ DISC-GRAN=\"([^\"]*)\"/ discardGranularity = '\1',/g" | \
    sed -r "s/ DISC-MAX=\"([^\"]*)\"/ discardMaximumBytes = '\1',/g" | \
    sed -r "s/ DISC-ZERO=\"([^\"]*)\"/ discardZeroesBytes = '\1',/g" | \
    sed -r "s/ WSAME=\"([^\"]*)\"/ writeSameMaximumBytes = '\1',/g" | \
    sed -r "s/ WWN=\"([^\"]*)\"/ uniqueStorageIdentifier = '\1',/g" | \
    sed -r "s/ RAND=\"([^\"]*)\"/ addsRandomness = \1,/g" | \
    sed -r "s/ PKNAME=\"([^\"]*)\"/ internalParentKernelDeviceName = '\1',/g" | \
    sed -r "s/ HCTL=\"\"//g" | \
    sed -r "s/ HCTL=\"([[:digit:]]+):([[:digit:]]+):([[:digit:]]+):([[:digit:]]+)\"/ scsiHost = \1, scsiChannel = \2, scsiTarget = \3, scsiLUN = \4,/g" | \
    sed -r "s/ TRAN=\"([^\"]*)\"/ transportType = '\1',/g" | \
    sed -r "s/ SUBSYSTEMS=\"([^\"]*)\"/ subsystems = '\1',/g" | \
    sed -r "s/ REV=\"([^\"]*)\"/ revision = '\1',/g" | \
    sed -r "s/ VENDOR=\"([^\"]*)\"/ vendor = '\1',/g" | \
    sed -r "s/ ZONED=\"([^\"]*)\"/ zoneModel = '\1',/g" | \
    sed -r "s/$/\nhostID = @currenthost\n;/g" | \
    sed -r "s/ = '',/ = NULL,/g" | \
    sed -r "s/ = ,/ = NULL,/g" | \
    sed -r "s/', /',\n/g" | \
    sed -r "s/\S+=\"\"//g" | \
    sed -r "s/([[:digit:]]), /\1,\n/g" | \
    sed -r "s/\), /),\n/g" | \
    sed -r "s/NULL, /NULL,\n/g" >> ${OUTPUT_FILE}
fi

#
# Services
#

OUTPUT_FILE=${OUTPUT_FOLDER}/services.sql
>${OUTPUT_FILE}
echo "INSERT INTO Services VALUES " >> ${OUTPUT_FILE}
cat /etc/services | \
sed '/^\s*$/d' | \
sed '/^\s*#/d' | \
sed -r "s/'/''/g" | \
sed -r "s/#\s*$//g" | \
sed -r "s/^(\S+)\s+([[:digit:]]+)\/(\S+)\s*$/\t(@currenthost, '\1', \2, '\3', NULL, NULL),/g" | \
sed -r "s/^(\S+)\s+([[:digit:]]+)\/(\S+)\s*#\s*$/\t(@currenthost, '\1', \2, '\3', NULL, NULL),/g" | \
sed -r "s/^(\S+)\s+([[:digit:]]+)\/(\S+)\s+([^#]+)\s*$/\t(@currenthost, '\1', \2, '\3', '\4', NULL),/g" | \
sed -r "s/^(\S+)\s+([[:digit:]]+)\/(\S+)\s+(.*)\s+# (.*)/\t(@currenthost, '\1', \2, '\3', '\4', '\5'),/g" | \
sed -r "s/^(\S+)\s+([[:digit:]]+)\/(\S+)\s+#\s*(.*)/\t(@currenthost, '\1', \2, '\3', NULL, '\4'),/g" | \
sed '$ s/.$//' >> ${OUTPUT_FILE} # This removes the trailing newline and comma
echo ";" >> ${OUTPUT_FILE}

#
# Protocols
#

OUTPUT_FILE=${OUTPUT_FOLDER}/protocols.sql
>${OUTPUT_FILE}
echo "INSERT INTO InternetProtocolV4Protocols VALUES " >> ${OUTPUT_FILE}
cat /etc/protocols | \
sed '/^\s*$/d' | \
sed '/^\s*#/d' | \
sed -r "s/'/''/g" | \
sed -r "s/#\s*$//g" | \
sed -r "s/^(\S+)\s+([[:digit:]]+)\s*$/\t(@currenthost, '\1', \2, NULL, NULL),/g" | \
sed -r "s/^(\S+)\s+([[:digit:]]+)\s+([^#\s]+)\s*$/\t(@currenthost, '\1', \2, '\3', NULL),/g" | \
sed -r "s/^(\S+)\s+([[:digit:]]+)\s+# (.*)$/\t(@currenthost, '\1', \2, NULL, '\3'),/g" | \
sed -r "s/^(\S+)\s+([[:digit:]]+)\s+([^#]+)\s+# (.*)$/\t(@currenthost, '\1', \2, '\3', '\4'),/g" | \
sed '$ s/.$//' >> ${OUTPUT_FILE} # This removes the trailing newline and comma
echo ";" >> ${OUTPUT_FILE}

#
# Static Hosts
#

OUTPUT_FILE=${OUTPUT_FOLDER}/statichosts.sql
>${OUTPUT_FILE}
echo "INSERT INTO StaticHosts VALUES " >> ${OUTPUT_FILE}
cat /etc/hosts | \
sed '/^\s*$/d' | \
sed '/^\s*#/d' | \
sed -r "s/'/''/g" | \
sed -r "s/#.*$//g" | \
sed -r "s/^\s*(\S+)\s+(\S+)\s+(.+)/\t(@currenthost, '\1', '\2', '\3'),/g" | \
sed -r "s/^\s*(\S+)\s+(\S+)$/\t(@currenthost, '\1', '\2', NULL),/g" | \
sed '$ s/.$//' >> ${OUTPUT_FILE} # This removes the trailing newline and comma
echo ";" >> ${OUTPUT_FILE}

#
# Python Packages
#

which pip > /dev/null
if [ $? -eq 0 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/pythonpackages.sql
    >${OUTPUT_FILE}
    echo "INSERT INTO PythonPackages VALUES " >> ${OUTPUT_FILE}
    pip list -o --format columns | \
    sed '/^Package\s+Version\s+Latest\s+Type/d' | \
    sed '/^\-+/d' | \
    sed '/^You /d' | \
    sed -r "s/^(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s*$/\t('\1', '\2', '\3', '\4'),/g" | \
    sed '$ s/.$//' >> ${OUTPUT_FILE} # This removes the trailing newline and comma
    echo ";" >> ${OUTPUT_FILE}
fi

#
# /etc/resolv.conf Resolvers
#

OUTPUT_FILE=${OUTPUT_FOLDER}/resolv.sql
>${OUTPUT_FILE}
echo "INSERT INTO EtcResolvResolvers VALUES " >> ${OUTPUT_FILE}
cat /etc/resolv.conf | \
sed '/^[^n].*/d' | \
sed -r "s/^nameserver\s+(\S+)\s*$/\t(@currenthost, '\1'),/g" | \
sed '$ s/.$//' >> ${OUTPUT_FILE} # This removes the trailing newline and comma
echo ";" >> ${OUTPUT_FILE}

#
# Logged In Users
#

which w > /dev/null
if [ $? -eq 0 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/loggedinusers.sql
    >${OUTPUT_FILE}
    echo "INSERT INTO LoggedInUsers VALUES " >> ${OUTPUT_FILE}
    w -f -h | \
    sed -r "s/(\S+)\s+(\w+)\/([[:digit:]]+)\s+(\S+)\s+(\S+)\s+([[:digit:]]+)\.[[:digit:]][[:digit:]]s\s+([[:digit:]]+)\.[[:digit:]][[:digit:]]s\s+([[:digit:]]+)\.[[:digit:]][[:digit:]]s\s+(.*)/\t(@currenthost, '\1', '\2', '\3', '\4', '\5', \6, \7, \8, '\9'),/g" | \
    sed '$ s/.$//' >> ${OUTPUT_FILE} # This removes the trailing newline and comma
    echo ";" >> ${OUTPUT_FILE}
fi

#
# NPM Packages
#

which npm > /dev/null
if [ $? -eq 0 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/npms.sql
    >${OUTPUT_FILE}
    npm list -global -long -parseable | \
    sed -r "s/^([^:]+):([^@]+)@([^:]+):(.*)/\t(@currenthost, '\2', '\3', '\1', '\4'),/g" | \
    sed '/^\/usr\/lib::undefined/d' | \
    sed '$ s/.$//' >> ${OUTPUT_FILE} # This removes the trailing newline and comma
    echo ";" >> ${OUTPUT_FILE}
fi

#
# Ruby Gems
# TODO: Add --details later
#

which gem > /dev/null
if [ $? -eq 0 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/gems.sql
    >${OUTPUT_FILE}
    gem query --local | \
    sed '/^\*\*\* LOCAL GEMS \*\*\*/d' | \
    sed -r "s/^(\S+)\s+\(([^\)]+)\)$/INSERT INTO RubyGems VALUE (@currenthost, '\1', '\2');/g" >> ${OUTPUT_FILE}
fi

#
# FSTab Mounts
#

OUTPUT_FILE=${OUTPUT_FOLDER}/fstab.sql
>${OUTPUT_FILE}
cat /etc/fstab | \
sed '/^\s*$/d' | \
sed '/^#.*/d' | \
sed -r "s/^(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+([[:digit:]])\s+([[:digit:]])/INSERT INTO FSTabMounts VALUE (@currenthost, '\1', '\2', '\3', '\4', \5, \6);/g" >> ${OUTPUT_FILE}

#
# lspci
# TODO: Change this to lspci -vvv
#

which lspci > /dev/null
if [ $? -eq 0 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/pci.sql
    >${OUTPUT_FILE}
    lspci | \
    sed -r "s/^([[:digit:]]+):([[:digit:]]+)\.([[:digit:]])\s+([^:]+):\s+(.*)/INSERT INTO PeripheralComponentInterconnectDevices VALUE (@currenthost, NULL, \1, \2, \3, '\4', '\5');/g" >> ${OUTPUT_FILE}
fi

#
# Running Processes
#
# Unfortunately, because there are too many fields, I have to use perl instead
# of sed, because sed is limited to 10 back-references.
#
# POSIX-Compliant Displays:
# ps -eo args,comm,etime,group,nice,pcpu,pgid,pid,ppid,rgroup,ruser,time,tty,user,vsz
#
# TODO: Review the command-line options -m and others
#

OUTPUT_FILE=${OUTPUT_FOLDER}/processes.sql
>${OUTPUT_FILE}

FIND_STRING="^\s*(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S.*)$"
REPL_STRING="INSERT INTO RunningProcesses VALUE (\@currenthost, \$1, \$2, \$3, \$4, \$5, \$6, \$7, \$8, \$9, \$10, \$11, \$12, '\$13', '\$14', '\$15', '\$16', '\$17', '\$18', '\$19', '\$20', '\$21', CAST(0x\$22 AS UNSIGNED INTEGER), CAST(0x\$23 AS UNSIGNED INTEGER), '\$24', '\$25', '\$26', '\$27', '\$28', \$29, \$30, '\$31', '\$32', \$33, \$34, '\$35', \$36, \$37, \$38, '\$39', '\$40', '\$41', \$42, CAST(0x\$43 AS UNSIGNED INTEGER), CAST(0x\$44 AS UNSIGNED INTEGER), CAST(0x\$45 AS UNSIGNED INTEGER), \$46, \$47, \$48, CAST(0x\$49 AS UNSIGNED INTEGER), \$50, \$51, \$52, \$53, \$54, '\$55', '\$56', '\$57');"

ps -eo \
pid,ppid,tpgid,pgrp,tid,\
pidns,ipcns,netns,mntns,utsns,userns,\
ouid,euser,ruser,egroup,rgroup,fuser,fgroup,suser,sgroup,supgrp,\
ignored,pending,\
machine,cgroup,unit,tty,seat,session,lsession,slice,uunit,\
etimes,sched,cputime,ni,pri,psr,rtprio,state,sgi_p,nlwp,\
esp,eip,stackp,drs,maj_flt,min_flt,nwchan,pmem,rssize,size,sz,vsz,\
label,flags,args | \
tail -n +2 | \
sed -r "s/'/''/g" | \
perl -pe "s/${FIND_STRING}/${REPL_STRING}/g" | \
sed -r "s/ \\-,/ NULL,/g" | \
sed -r "s/ '\\-',/ NULL,/g" | \
sed -r "s/ \\? ,/ NULL,/g" | \
sed -r "s/ '\\?',/ NULL,/g" | \
sed -r "s/ \\-1,/ NULL,/g" | \
sed -r "s/ '<defunct>'/ NULL/g" | \
sed -r "s/ CAST\\(0x\\- AS UNSIGNED INTEGER\\),/ NULL,/g" >> ${OUTPUT_FILE}

#
# SSH Known Hosts
#

OUTPUT_FILE=${OUTPUT_FOLDER}/knownhosts.sql
>${OUTPUT_FILE}
for user in $(cut -f1 -d: /etc/passwd)
do
    if [ -f /home/$user/.ssh/known_hosts ]; then
        cat /home/$user/.ssh/known_hosts | \
        sed -r "s/'/''/g" | \
        sed -r "s/^(\\S+)\\s+(\\S+)\\s+(\\S+)\s+(\S.*)/\\tINSERT INTO SSHKnownHosts VALUE (@currenthost, '\\1', '\\2', FROM_BASE64('\\3'), '\\4');/g" | \
        sed -r "s/^(\\S+)\\s+(\\S+)\\s+(\\S+)\s*$/\\tINSERT INTO SSHKnownHosts VALUE (@currenthost, '\\1', '\\2', FROM_BASE64('\\3'), NULL);/g" >> ${OUTPUT_FILE}
    fi
done

#
# SSH Authorized Keys
# Protocol 2 public key consist of: options, keytype, base64-encoded key, comment
# This does not save Protocol 1 keys
# TODO: Add user field to AuthorizedKeys
#

# "The options field is optional; its presence is determined by whether the line starts with a number or not (the options field never starts with a number)."
# -- ssh man page
OUTPUT_FILE=${OUTPUT_FOLDER}/authkeys.sql
>${OUTPUT_FILE}
for user in $(cut -f1 -d: /etc/passwd)
do
    if [ -f /home/$user/.ssh/authorized_keys ]; then
        cat /home/$user/.ssh/authorized_keys | \
        sed -r "s/'/''/g" | \
        sed -r "s/(.*)\\s+(\\S+)\\s+(\\S+)\\s+(\\S+)\\s*$/\\tINSERT INTO SSHAuthorizedKeys VALUE (@currenthost, '\\1', '\\2', FROM_BASE64('\\3'), '\\4');/g" | \
        sed -r "s/^\\s*(\\S+)\\s+(\\S+)\\s+(\\S+)\\s*$/\\tINSERT INTO SSHAuthorizedKeys VALUE (@currenthost, NULL, '\\1', FROM_BASE64('\\2'), '\\3');/g" >> ${OUTPUT_FILE}
    fi
done

#
# Bash Command History
#

# TODO: Cut out any PMOSQ-related commands
OUTPUT_FILE=${OUTPUT_FOLDER}/history.sql
>${OUTPUT_FILE}
for user in $(cut -f1 -d: /etc/passwd)
do
    if [ -f /home/$user/.bash_history ]; then
        cat /home/$user/.bash_history | \
        sed -r "s/'/''/g" | \
        sed -r "s/\\s*(\\S.*\\S)\\s*$/\\tINSERT INTO BashCommandHistories VALUE (@currenthost, ${user}, '\\1');/g" >> ${OUTPUT_FILE}
    fi
done

#
# NetworkHardwareInterfaces
# Flags described here: http://man7.org/linux/man-pages/man7/netdevice.7.html
#

which ip > /dev/null
if [ $? -eq 0 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/ip.sql
    >${OUTPUT_FILE}
    ip address show | \
    sed -r "s/^\\s*([[:digit:]]+):\\s+([^:]+):\\s+<[^>]*> mtu ([[:digit:]]+) qdisc (\\S+) state (\\w+) group (\\S+) qlen ([[:digit:]]+)\\s*/INSERT INTO NetworkHardwareInterfaces (hostID, name, maximumTransmissionUnit, queueDiscipline, group, queueLength) VALUES (@currenthost, '\\2', \\3, '\\4', '\\6', \\7);\nSET @currentinterface = LAST_INSERT_ID();/g" | \
    sed -r "s/^\\s+link\\/(\\S+)\\s+([0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]:[0-9a-f][0-9a-f])\\s+brd\\s+([0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]:[0-9a-f][0-9a-f])\\s*/INSERT INTO NetworkLinkLayerInterfaces VALUE (@currenthost, @currentinterface, '\\1', '\\2', '\\3');/g" | \
    sed -r "s/^\\s+inet ([[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3})\\/([[:digit:]]{1,2}) brd ([[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}).*/INSERT INTO NetworkInternetLayerInterfaces VALUES (@currenthost, @currentinterface, '\\1', '\\2', '\\3');/g" | \
    sed -r "s/^\\s+inet ([[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3})\\/([[:digit:]]{1,2}).*/INSERT INTO NetworkInternetLayerInterfaces VALUES (@currenthost, @currentinterface, '\\1', '\\2', NULL);/g" | \
    sed -r "s/^\\s{7}/\\-\\- /g" >> ${OUTPUT_FILE}
fi

#
# IP Neighbors
#

which ip > /dev/null
if [ $? -eq 0 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/neighbors.sql
    >${OUTPUT_FILE}
    ip neighbor show | \
    sed -r "s/^([[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}) dev (\\S+) lladdr ([0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]:[0-9a-f][0-9a-f]) (\\w+)\\s*/INSERT INTO IPNeighbors VALUE (@currenthost, '\\1', '\\2', '\\3', '\\4');/g" >> ${OUTPUT_FILE}
fi

#
# Network Scripts
#
# This might be a bit difficult, because a lot of fields can vary in number
# http://gintohewoo.com/linuxdocs/rhl-rg-en-8.0/s1-networkscripts-interfaces.html
#

OUTPUT_FILE=${OUTPUT_FOLDER}/networkscripts.sql
>${OUTPUT_FILE}
for configfile in $(ls -1 /etc/sysconfig/network-scripts/ifcfg-*)
do
    cat $configfile | \
    sed '/^#.*/d' | \
    sed -r "s/\"/'/g" | \
    sed -r "s/^([A-Z0-9_]+)=([^'].*)/\\1='\\2'/g" | \
    sed -r "s/='([0-9]+)'\\s*/=\\1/g" | \
    sed "s/'yes'/TRUE/g" | \
    sed "s/'no'/FALSE/g" >> ${OUTPUT_FILE}
done

#
# TLS Certs
#

which openssl > /dev/null
if [ $? -eq 0 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/trustedcerts.sql
    >${OUTPUT_FILE}
    if [ -f /etc/pki/tls/certs/ca-bundle.trust.crt ]; then
        cat /etc/pki/tls/certs/ca-bundle.trust.crt | \
        sed '/^[^#].*/d' | \
        sed '/^\s*$/d' | \
        sed -r "s/^# (.*)/INSERT INTO TrustedRootCertificateAuthorities VALUE (@currenthost, '\\1');/g" >> ${OUTPUT_FILE}
    elif [ -d /etc/ssl/certs ]; then
        for certfile in $(ls -1 /etc/ssl/certs)
        do
            openssl x509 -in /etc/ssl/certs/$certfile -inform PEM -noout -text | \
            grep 'Subject:' | \
            sed -r 's/^\s+Subject: (.*)/\1/g' | \
            sed "s/'/''/g" | \
            sed -r "s/(.*)/INSERT INTO TrustedRootCertificateAuthorities VALUE (@currenthost, '\\1');/g" >> ${OUTPUT_FILE}
        done
    fi
fi

#
# User Accounts
#

OUTPUT_FILE=${OUTPUT_FOLDER}/accounts.sql
>${OUTPUT_FILE}
cat /etc/passwd | \
sed -r "s/^([^:]*):([^:]*):([^:]*):([^:]*):([^:]*):([^:]*):(.*)/INSERT INTO PasswdAccounts VALUE (@currenthost, '\\1', \\3, \\4, '\\5', '\\6', '\\7');/g" >> ${OUTPUT_FILE}

#
# SELinux File Contexts
#
# https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/SELinux_Guide/rhlcommon-section-0037.html
#

# cat /etc/selinux/targeted/contexts/files/file_contexts

#
# SELinuxBooleans
#

which getsebool > /dev/null
if [ $? -eq 0 -a SELINUX_ENABLED == 1 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/booleans.sql
    >${OUTPUT_FILE}
    getsebool -a | \
    sed -r "s/^(\\S+) \\-\\-> off/INSERT INTO SELinuxBooleans VALUE (@currenthost, '\\1', FALSE);/g" | \
    sed -r "s/^(\\S+) \\-\\-> on/INSERT INTO SELinuxBooleans VALUE (@currenthost, '\\1', TRUE);/g" >> ${OUTPUT_FILE}
fi

#
# USB Devices
#

which lsusb > /dev/null
if [ $? -eq 0 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/usb.sql
    >${OUTPUT_FILE}
    lsusb | \
    sed -r "s/^Bus ([[:digit:]]+) Device ([[:digit:]]+): ID ([0-9a-f]{4}):([0-9a-f]{4}) (.*)/INSERT INTO USBDevices VALUE (@currenthost, \\1, \\2, CAST(0x\\3 AS INTEGER UNSIGNED), CAST(0x\\4 AS INTEGER UNSIGNED), '\\5');/g" >> ${OUTPUT_FILE}
fi

#
# APT Repositories
#

if [ -f /etc/apt/sources.list ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/aptrepos.sql
    >${OUTPUT_FILE}
    cat /etc/apt/sources.list | \
    sed '/^#.*/d' | \
    sed -r "s/^(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(.*)/INSERT INTO APTRepositories VALUE (@currenthost, '\\1', '\\2', '\\3', '\\4');/g" >> ${OUTPUT_FILE}
fi

if [ -d /etc/apt/sources.list.d ]; then
    for sourcefile in $(ls -1 /etc/apt/sources.list.d)
    do
        cat $sourcefile | \
        sed '/^#.*/d' | \
        sed -r "s/^(\\S+)\\s+(\\S+)\\s+(\\S+)\\s+(.*)/INSERT INTO APTRepositories VALUE (@currenthost, '\\1', '\\2', '\\3', '\\4');/g" >> ${OUTPUT_FILE}
    done
fi

#
# Installed Deb Packages
#
# Description=${Description} \nConffiles=${Conffiles} \nbugs=\${Bugs} \nconfig-Version=\${Config-Version}
# \nfilename=\${Filename} \nmsDOSFilename=\${MSDOS-Filename} \norigin='\${Origin}' \nrevision='\${Revision}'
# \ntag=\${Tag}\ntriggersAwaited=\${Triggers-Awaited}\ntriggersPending=\${Triggers-Pending}

which dpkg-query > /dev/null
if [ $? -eq 0 ]; then
    OUTPUT_FILE=${OUTPUT_FOLDER}/debs.sql
    >${OUTPUT_FILE}
    dpkg-query -W --showformat="INSERT INTO InstalledDebianPackages SET\n\thostID=@currenthost,\n\tarchitecture='\${Architecture}',\n\tconflicts='\${Conflicts}',\n\tbreaks='\${Breaks}',\n\tdepends='\${Depends}',\n\tenhances='\${Enhances}',\n\tessential=\${Essential},\n\thomepage='\${Homepage}',\n\tinstalledSize=\${Installed-Size},\n\tmd5Sum='\${MD5sum}',\n\tmaintainer='\${Maintainer}',\n\tpackage='\${Package}',\n\tpreDepends='\${Pre-Depends}',\n\tpriority='\${Priority}',\n\tsection='\${Section}',\n\tsize=\${Size},\n\tsource='\${Source}',\n\tstatus='\${Status}',\n\tsuggests='\${Suggests}',\n\tversion='\${Version}',\n\tbinaryPackage='\${binary:Package}',\n\tsourcePackage='\${source:Package}',\n\tsourceVersion='\${source:Version}',\n\tsourceUpstreamVersion='\${source:Upstream-Version}',\n;\n\n" >> ${OUTPUT_FILE}
fi