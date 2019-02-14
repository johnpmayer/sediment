
export PATH="$coreutils/bin:$findutils/bin:$scala_2_11/bin"
echo "Using path: $PATH"

mkdir $out
files=$(find $srcs -type f)
echo "Using files: $files"
scalac -d $out $files