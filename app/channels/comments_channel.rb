class CommentsChannel < ApplicationCable::Channel
  def follow(params)
    stop_all_streams
    stream_from "post:#{params['post_id'].to_i}"
  end

  def unfollow
    stop_all_streams
  end

  def currentUserId
    current_user.id
  end
end