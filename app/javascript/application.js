import { Turbo } from "@hotwired/turbo-rails";
import $ from "jquery";

window.$ = $;

/* Scrolls messages to bottom when the page renders so user doesn't have to */ 
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

/* Waits for new messages then scrolls to bottom so chat updates automaticaly */ 
$(document).ready(function() {
  function fetchMessages() {
    var chatId = $('#messages-container').data('chat-id');
    var projectId = $('#messages-container').data('project-id');
    if (!chatId || !projectId) return;

    $.ajax({
      url: '/projects/' + projectId + '/chats/' + chatId + '/messages',
      type: 'GET',
      dataType: 'script',
      success: function() {
        console.log('Messages fetched successfully');
      },
      error: function(xhr, status, error) {
        console.error('Failed to fetch messages:', status, error);
      }
    });
  }
  setInterval(fetchMessages, 5000);
});
