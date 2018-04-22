class Comment < ApplicationRecord
  after_create_commit { RenderCommentJob.perform_later self, "create" }
  after_update_commit { RenderCommentJob.perform_later self, "update" }
  before_destroy { RenderCommentJob.perform_now self, "destroy" }
  belongs_to :post
  belongs_to :user
  validates :body, presence: true
end
