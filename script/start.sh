#!/bin/bash --login

date=`date +"%Y%m%d"`
#rvm use 2.0.0
#nohup rackup ../config.ru > xinTest2.log &
export KEY1='AKlMU89D3FchIkhK'
export KEY2='L97fYJp1oPbSMV0n'
export KEY3='S94sYJp2oPvSMQ0m'

nohup rails s -p 3001 > xinTest2.log.$date 2>&1 &