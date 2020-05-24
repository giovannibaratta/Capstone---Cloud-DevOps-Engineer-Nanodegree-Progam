# $1 : stack name
# $2 : template body file name

WAIT=0

# Arguments parsing without required (last 2)
for arg in "${@:1:$#-2}"
do
    case $arg in
        
        --wait)
        WAIT=1
        shift # Remove argument name
        ;;
        
        *)
        echo "Unknown argument -> $1"
        exit 1
        ;;
    esac
done

chmod u+x cloud-formation-helper.sh

./cloud-formation-helper.sh update "$@"

EXIT_CODE=$?

if [ "$EXIT_CODE" -ne 0 ]
then
    echo "Error !! Stack not updated."
    exit 128
fi

if [ "$WAIT" -e 0 ]
then
    aws cloudformation wait stack-update-complete --stack-name "$1"

    if [ "$EXIT_CODE" -ne 0 ]
    then
        echo "Error !! Stack not updated."
        exit 129
    fi
fi