namespace :clean_tags do
  desc "参照されていないタグデータの削除を行う"
  task tag_name: :environment do
    use_tags = TagMap.pluck(:tag_id)
    unuse_tags = Tag.pluck(:id)
    clean_tags = unuse_tags - use_tags
    Tag.delete(clean_tags)
  end
end
