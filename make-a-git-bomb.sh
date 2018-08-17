leaf=$(echo content | git hash-object -w --stdin)
node=$(for n in a b c d e f g h i j; do
         echo -e "100644 blob $leaf\t$n"
       done | git mktree)
for level in `seq 2 6`; do
  node=$(for n in a b c d e f g h i j; do
         echo -e "040000 tree $node\t$n"
       done | git mktree)
done
other=$(seq 1 10 | git hash-object -w --stdin)
subdir=$(echo -e "100644 blob $other\ttoken-file" | git mktree)
toplevel=$(echo -e "040000 tree $node\tbomb\n040000 tree $subdir\trelevant" \
           | git mktree)
commit=$(git commit-tree -m 'You da bomb' $toplevel)
git update-ref refs/heads/bomb $commit
