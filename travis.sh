#! /bin/bash -ex

echo "現在の場所\n"
pwd

echo "userとemailの設定\n"
git config --global user.name
git config --global user.email

# specで使うvcrファイルをダウンロードしてくる
echo "vcrで使うファイルをダウンロードします"
/bin/mkdir -p spec/fixtures/vcr
pushd spec/fixtures/vcr
  curl --request GET \
       --header "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" \
       'https://gitlab.com/api/v4/projects/3808577/repository/files/spec%2Ffixtures%2Fvcr%2Fadd_content%2Eyml/raw?ref=master' > add_content.yml
  curl --request GET \
         --header "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" \
         'https://gitlab.com/api/v4/projects/3808577/repository/files/spec%2Ffixtures%2Fvcr%2Fcreate_summary%2Eyml/raw?ref=master' > create_summary.yml
  ls -1
popd


