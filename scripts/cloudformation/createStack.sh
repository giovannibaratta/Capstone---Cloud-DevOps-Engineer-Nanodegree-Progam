# $1 : stack name
# $2 : template body file name
# --overwrite : delete the stack if present

WAIT=0
OVERWRITE_STACK=0

# Arguments parsing without required (last 2)
for arg in "${@:1:$#-2}"
do
    case $arg in
        
        --overwrite)
        OVERWRITE_STACK=1
        shift # Remove argument name
        ;;

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

if [ "$OVERWRITE_STACK" -e 0 ]
then
    STACK_NAME=$1
    echo "Deleting stack if present ..."
    aws cloudformation delete-stack --stack-name "$STACK_NAME"
    aws cloudformation wait stack-delete-complete --stack-name "$STACK_NAME"
fi

chmod u+x cloud-formation-helper.sh
./cloud-formation-helper.sh create "$@"

EXIT_CODE=$?

if [ "$EXIT_CODE" -ne 0 ]
then
    echo "Error !! Stack not created."
    exit 128
fi


if [ "$WAIT" -e 0 ]
then
    aws cloudformation wait stack-create-complete --stack-name "$1"

    if [ "$EXIT_CODE" -ne 0 ]
    then
        echo "Error !! Stack not created."
        exit 129
    fi
fi