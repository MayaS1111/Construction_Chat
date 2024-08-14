import { Turbo } from "@hotwired/turbo-rails";
import $ from "jquery";

window.$ = $;

$(document).on('turbo:load', function() {
  const messagesContainer = $('#messages-container');

  const scrollToBottom = () => {
    messagesContainer.scrollTop(messagesContainer[0].scrollHeight);
  };

  scrollToBottom();

  $('#message-form').on('ajax:success', function(event) {
    const [_data, _status, xhr] = event.detail;

    scrollToBottom();
  });
});
