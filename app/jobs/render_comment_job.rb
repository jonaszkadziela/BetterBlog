class RenderCommentJob < ApplicationJob
  queue_as :default

  def perform(comment, method)
    count = comment.post.comments.count
    case method
    when "create"
      ActionCable.server.broadcast "post:#{comment.post_id}",
                                   comment_id: comment.id, comment: render_comment(comment),
                                   count: render_count(count), method: method
    when "update"
      ActionCable.server.broadcast "post:#{comment.post_id}",
                                   comment_id: comment.id, comment: render_comment(comment), method: method
    when "destroy"
      ActionCable.server.broadcast "post:#{comment.post_id}",
                                   comment_id: comment.id, count: render_count(count - 1), method: method
    end
  end

  private

  def render_comment(comment)
    CommentsController.render(partial: "comments/new_comment", locals: { comment: comment })
  end

  def render_count(count)
    CommentsController.render(partial: "comments/new_count", locals: { count: count })
  end
end
