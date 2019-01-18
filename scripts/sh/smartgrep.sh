#!/bin/bash

usage()
{
	echo "Usage:`basename $0` -v [-p PREFIX] [-s SUFFIX] text"
	exit 1
}

[ $# -eq 0 ] && usage

while getopts :viEp:s: OPTION
do
	case $OPTION in
		v)
			VERBOSE=true
			;;
        i)
            GREP_OPT="${GREP_OPT} -i"
            ;;
        E)
            GREP_OPT="${GREP_OPT} -E"
            ;;
		p)
			PREFIX="${PREFIX},${OPTARG}"
			;;
		s)
			SUFFIX="${SUFFIX},${OPTARG}"
			;;
		\?)
			usage
			;;
	esac
done

shift $(($OPTIND -1))
[ $# -eq 0 ] && usage

PREFIX=(${PREFIX//,/ })
for prefix in ${PREFIX[@]}
do
	PATTERN="${PATTERN} -o -name "${prefix}*""
done

SUFFIX=(${SUFFIX//,/ })
for suffix in ${SUFFIX[@]}
do
	PATTERN="${PATTERN} -o -name "*\\.${suffix}""
done

PATTERN=${PATTERN#* -o }
set -f
[ "$VERBOSE" = "true" ] && set -x
find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f \( ${PATTERN} \) \
    -exec grep ${GREP_OPT} --color -n "$@" {} +
