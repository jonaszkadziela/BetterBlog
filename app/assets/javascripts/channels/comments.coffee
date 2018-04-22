App.comments = App.cable.subscriptions.create "CommentsChannel",
  collection: -> $('#comments-list')

  connected: ->
    setTimeout =>
      @followCurrentPost()
    , 1000

  disconnected: ->

  followCurrentPost: ->
    postId = @collection().data('post-id')
    if postId
      @perform 'follow', post_id: postId
    else
      @perform 'unfollow'

  received: (data) ->
    switch data.method
      when "create"
        if !@userIsCurrentUser(data.comment)
          @collection().prepend(data.comment)
          $('#comments-count').html(data.count)
      when "update"
        if !@userIsCurrentUser(data.comment)
          $('*[data-comment-id=' + data.comment_id + ']').parent().html(data.comment)
      when "destroy"
        $('*[data-comment-id=' + data.comment_id + ']').remove()
        $('#comments-count').html(data.count)

  userIsCurrentUser: (comment) ->
    $(comment).attr('data-user-id') is $('meta[name=current-user]').attr('id')