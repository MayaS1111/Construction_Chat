import { Turbo } from "@hotwired/turbo-rails";
import $ from "jquery";

// Ensure jQuery is globally available
window.$ = $;

$(document).on('turbo:load', function() {
  const messagesContainer = $('#messages-container');

  const scrollToBottom = () => {
    messagesContainer.scrollTop(messagesContainer[0].scrollHeight);
  };

  // Initial scroll to bottom when page loads
  scrollToBottom();

  // Handle AJAX form submission
  $('#message-form').on('ajax:success', function(event) {
    const [_data, _status, xhr] = event.detail;

    // Scroll to bottom after receiving new message
    scrollToBottom();
  });
});
