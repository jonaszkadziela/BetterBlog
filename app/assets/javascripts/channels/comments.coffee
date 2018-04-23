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
    if data.comment_id != null
      comment = @getCommentById(data.comment_id)
    switch data.method
      when "create"
        if !@userIsCurrentUser(data.comment)
          @collection().append(data.comment)
          $('#comments-count').html(data.count)
          @getCommentById(data.comment_id).animateCss 'zoomIn'
      when "update"
        if !@userIsCurrentUser(data.comment)
          comment.parent().html(data.comment)
          @getCommentById(data.comment_id).animateCss 'pulse'
      when "destroy"
        comment.animateCss 'zoomOut', ->
          comment.remove()
        $('#comments-count').html(data.count)

  userIsCurrentUser: (comment) ->
    $(comment).attr('data-user-id') is $('meta[name=current-user]').attr('id')

  getCommentById: (comment_id) ->
    $('*[data-comment-id=' + comment_id + ']')