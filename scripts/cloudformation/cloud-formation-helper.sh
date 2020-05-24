# $1 : action to execute, value: [create, update]
# $2 : stack name
# $3 : template body file name
 
PARAMS=""
ACTION=$1
STACK_NAME=$2
TEMPLATE_FILE=$3

if [ "$ACTION" != "create" ] && [ "$ACTION" != "update" ]
then
    echo "$ACTION is not a valid action [update, create]."
    exit 1
fi

#remove extension
TEMPLATE_FILE_NO_EXT=$(echo $TEMPLATE_FILE | awk '{split($0, output, ".yml"); print output[1]}' )

# check if a file <stack_name>.json is in the current directory
PARAMS_FILE="$TEMPLATE_FILE_NO_EXT.json"
echo "Searching $PARAMS_FILE in current dir ..."
find $PARAMS_FILE
FIND_RESULT=$?

if [ $FIND_RESULT -eq 0 ]
then
    # file found
    echo "Loading parameters file ..."
    PARAMS="--parameters file://$PARAMS_FILE"
fi

aws cloudformation "$ACTION"-stack \
        --region us-east-1 \
        --stack-name "$STACK_NAME" \
        --template-body file://"$TEMPLATE_FILE" \
        --capabilities CAPABILITY_IAM \
        $PARAMS