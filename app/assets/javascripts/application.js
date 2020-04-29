// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .


document.addEventListener('turbolinks:load', function () {
  $('#user_password_confirmation').on('keyup', function () {
    let passwordField = document.querySelector('#user_password')
    let messageBox    = document.querySelector('p.confirmation-message')

    if (this.value == '') {
      messageBox.innerText = ''
    } else if (this.value == passwordField.value) {
      messageBox.innerText = 'Passwords are equal'
      messageBox.classList.remove('red')
      messageBox.classList.add('green')
    } else {
      messageBox.innerText = 'Passwords are not equal'
      messageBox.classList.remove('green')
      messageBox.classList.add('red')
    }
  })

  setProgressBar();

  $('#feedback-link').on('click', function () {
    $('#feedback-modal').modal('show')
  })
})

function setProgressBar() {
  let progressBar = document.getElementById('progress-bar')

  if (progressBar) {
    let questionNumber = progressBar.dataset.questionNumber - 1;
    let questionsCount = progressBar.dataset.questionsCount;
    let width = 100 * questionNumber/questionsCount;

    let progressLine = document.getElementById('progress-bar-line');
    progressLine.style.width = width + '%';
    progressLine.innerText = Math.round(width) + '%';
  }
}

function setTestTimer() {
  let duration = $('.timer').data('duration')

  if (duration) {
    let countDownDateTime = new Date().getTime() + duration * 20 * 1000

    let t = setInterval(function() {
      let dateTimeNow = new Date().getTime();
      let distance = countDownDateTime - dateTimeNow

      let hours   = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
      let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60))
      let seconds = Math.floor((distance % (1000 * 60)) / 1000)

      document.getElementById("timer").innerHTML = hours + "h " + minutes + "m " + seconds + "s "

      if (distance < 1000) {
        clearInterval(t);
        alert('Время истекло.')
        finishTestPassage()
      }
    }, 1000);
  }
}

function finishTestPassage() {
  let testPassageId = window.location.pathname.replace('/test_passages/', '')
  let host = window.location.origin

  window.location.href = `${host}/test_passages/${testPassageId}/result`
}


