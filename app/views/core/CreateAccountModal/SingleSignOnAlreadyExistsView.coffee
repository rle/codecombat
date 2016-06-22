BasicInfoView = require 'views/core/CreateAccountModal/BasicInfoView'
template = require 'templates/core/create-account-modal/single-sign-on-already-exists-view'
forms = require 'core/forms'
User = require 'models/User'

module.exports = class SingleSignOnAlreadyExistsView extends BasicInfoView
  id: 'single-sign-on-already-exists-view'
  template: template

  events: _.extend {}, BasicInfoView.prototype.events, {
    'click .sso-login-btn': 'onClickSsoLoginButton'
  }

  initialize: ({ @sharedState } = {}) ->

  onClickSsoLoginButton: ->
    options = {
      context: @
      success: -> window.location.reload()
      error: ->
        @$('#gplus-login-btn').text($.i18n.t('login.log_in')).attr('disabled', false)
        errors.showNotyNetworkError(arguments...)
    }
    
    if @sharedState.get('ssoUsed') is 'gplus'
      me.loginGPlusUser(@sharedState.get('ssoAttrs').gplusID, options)
      @$('#gplus-login-btn').text($.i18n.t('login.logging_in')).attr('disabled', true)
    else if @sharedState.get('ssoUsed') is 'facebook'
      me.loginFacebookUser(@sharedState.get('ssoAttrs').facebookID, options)
      @$('#facebook-login-btn').text($.i18n.t('login.log_in')).attr('disabled', false)
    else
      console.log "Uh oh, we didn't record which SSO they used"