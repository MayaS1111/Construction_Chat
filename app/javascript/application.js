// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails";
import $ from "jquery";

window.$ = $;

console.log('Script loaded');
// Scrolls messages to bottom when the page renders so user doesn't have to  
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

// Waits for new messages then scrolls to bottom so chat updates automaticaly 
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

$(document).on('turbolinks:load', function() {
  // Handle clicks on project items
  $('.project-item a').on('click', function(event) {
    event.preventDefault(); // Prevent the default link behavior

    const url = $(this).attr('href'); // Get the URL from the href attribute

    // Perform an AJAX request to fetch the content
    $.ajax({
      url: url,
      method: 'GET',
      success: function(response) {
        // Update the content of a specific part of the page
        $('#full-page').html(response); // Insert the new content
      },
      error: function() {
        alert('An error occurred while loading the chat content.');
      }
    });
  });
  $('.chat-item a').on('click', function(event) {
    event.preventDefault(); // Prevent the default link behavior

    const url = $(this).attr('href'); // Get the URL from the href attribute

    // Perform an AJAX request to fetch the content
    $.ajax({
      url: url,
      method: 'GET',
      success: function(response) {
        // Update the content of a specific part of the page
        $('#full-page').html(response); // Insert the new content
      },
      error: function() {
        alert('An error occurred while loading the chat content.');
      }
    });
  });
});
