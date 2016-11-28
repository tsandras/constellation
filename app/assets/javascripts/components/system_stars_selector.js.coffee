@SystemStars = React.createClass
  render: ->
    React.DOM.div
      className: 'system-stars'
      React.DOM.span
      'Choose type of stellar system !'

@SystemStarsSelector = React.createClass
  getInitialState: () ->
    showSystemStars: false
  handleSystemStars: (e) ->
    if @state.showSystemStars
      @setState showSystemStars: false
    else
      @setState showSystemStars: true
  render: ->
    React.DOM.div
      className: 'system-stars-handle'
      React.DOM.span
        onClick: @handleSystemStars
        className: 'system-stars-selector'
        'Stellar system'
      if @state.showSystemStars 
        React.createElement SystemStars
