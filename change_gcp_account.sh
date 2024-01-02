#! /bin/bash

#=========================================
# 腳本設定
email_array=("ian_zhuang@gmail.com" "880831ian@gmail.com")

#=========================================
# 顏色設定
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # 重置颜色

PS3='請選擇要使用的 Google 帳號(輸入開頭數字): '
select email in "${email_array[@]}"; do
    case $email in
    "ian_zhuang@gmail.com")
        configurations="default"
        cluster="gke_gcp-XXXXXXX"
        echo "\n選擇${YELLOW} $configurations ${NC}/${YELLOW} $email ${NC}作為使用帳號"
        break
        ;;
    "880831ian@gmail.com")
        configurations="presonal"
        cluster="gke_gcp-XXXXXXX"
        echo "\n選擇${YELLOW} $configurations ${NC}/${YELLOW} $email ${NC}作為使用帳號"
        break
        ;;
    *)
        echo "${RED}無效參數 ($REPLY)，請重新輸入${NC}"
        ;;
    esac
done

rm -rf ~/.kube/gke_gcloud_auth_plugin_cache
rm -rf ~/.kube/cache/ && rm -rf ~/.kube/http-cache/
gcloud config configurations activate $configurations 2>/dev/null
gcloud config set account $email
kubectl config use-context $cluster

echo "\n${BLUE}顯示目前帳號資訊${NC}\n"
gcloud config list
gcloud config configurations list
