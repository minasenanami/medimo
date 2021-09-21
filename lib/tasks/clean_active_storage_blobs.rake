namespace :clean_active_storage_blobs do
  desc "ActionTextに添付したが使用しなかった画像データを削除"
  task metadata: :environment do
    ActiveStorage::Blob.includes(:variant_records, :preview_image_attachment).unattached.each(&:purge) if ActiveStorage::Blob.unattached.any?
  end
end
