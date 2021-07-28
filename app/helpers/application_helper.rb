module ApplicationHelper
  def following(user)
    if !current_user.following?(user)
      link_to 'Follow', add_follow_path(following_id: user)
    else
      link_to 'Unfollow', followings_destroy_path(following_id: user)
    end
  end
  def asset_exists?(path)
    if Rails.configuration.assets.compile
      Rails.application.precompiled_assets.include? path
    else
      Rails.application.assets_manifest.assets[path].present?
    end
  end
end
