git config core.sparseCheckout true
./make-a-git-bomb.sh
echo relevant >.git/info/sparse-checkout
time git checkout bomb

echo "Now, please run this:"
echo time git checkout -b newbranch
