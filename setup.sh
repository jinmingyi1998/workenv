groupadd -g ${GOUPDID:-100000}
useradd -u ${USERID:-1001} -g ${GROUPID:-100000} jinmingyi
usermod -aG sudo jinmingyi
echo "jinmingyi:1234" | chpasswd
