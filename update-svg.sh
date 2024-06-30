# Update svg file inplace.
# To be invoked like this:
# dot -Tsvg -otransactions.svg transactions.dot && ../../dynamic-SVG-from-Graphviz/update-svg.sh transactions.svg

if [ $# -ne 1 ]
then
    echo "Usage: update-svg <svg file path>"
    exit 1
fi

echo "Updating $1"

# Insert onload handler in <svg> tag and remove terminating </svg> tag
sed -i -e 's/<svg /<svg onload="addInteractivity(evt)" /' -e '/<\/svg/d' $1

# Append script
cat `echo $0 | sed 's/update-svg.sh/svg-script/'` >> $1

# Putback terminating </svg> tag
echo "</svg>" >> $1
