document.addEventListener('DOMContentLoaded', function() {
  function initializePrivateSidebar() {
    function togglePrivateChatSidebar() {
      var sidebar = document.getElementById('chat_col_box_private');
      if (sidebar) {
        var isClosed = sidebar.classList.contains('closed');
        if (isClosed) {
          sidebar.classList.remove('closed');
          localStorage.setItem('chatSidebarState', 'open');
        } else {
          sidebar.classList.add('closed');
          localStorage.setItem('chatSidebarState', 'closed');
        }
      } else {
        console.error('Element with id "chat_column_box_private" not found.');
      }
    }

    function loadPrivateChatSidebarState() {
      var sidebar = document.getElementById('chat_col_box_private');
      var sidebarState = localStorage.getItem('chatSidebarState');
      if (sidebar) {
        if (sidebarState === 'closed') {
          sidebar.classList.add('closed');
        } else {
          sidebar.classList.remove('closed');
        }
      }
    }

    loadPrivateChatSidebarState();

    // Attach the toggle function to the button
    var toggleButton = document.getElementById('chat_col_toggle_private');
    if (toggleButton) {
      toggleButton.addEventListener('click', togglePrivateChatSidebar);
    }
  }

  initializePrivateSidebar();

  // Handle route changes for Turbolinks or Turbo
  document.addEventListener('turbolinks:load', initializePrivateSidebar);
  document.addEventListener('turbo:load', initializePrivateSidebar);
});



document.addEventListener('DOMContentLoaded', function() {
  function initializepublicSidebar() {
    function togglepublicChatSidebar() {
      var sidebar = document.getElementById('chat_column_box_public');
      if (sidebar) {
        var isClosed = sidebar.classList.contains('closed');
        if (isClosed) {
          sidebar.classList.remove('closed');
          localStorage.setItem('chatSidebarState', 'open');
        } else {
          sidebar.classList.add('closed');
          localStorage.setItem('chatSidebarState', 'closed');
        }
      } else {
        console.error('Element with id "chat_column_box_public" not found.');
      }
    }

    function loadpublicChatSidebarState() {
      var sidebar = document.getElementById('chat_column_box_public');
      var sidebarState = localStorage.getItem('chatSidebarState');
      if (sidebar) {
        if (sidebarState === 'closed') {
          sidebar.classList.add('closed');
        } else {
          sidebar.classList.remove('closed');
        }
      }
    }

    loadpublicChatSidebarState();

    // Attach the toggle function to the button
    var toggleButton = document.getElementById('chat_col_toggle_public');
    if (toggleButton) {
      toggleButton.addEventListener('click', togglepublicChatSidebar);
    }
  }

  initializepublicSidebar();

  // Handle route changes for Turbolinks or Turbo
  document.addEventListener('turbolinks:load', initializepublicSidebar); 
  document.addEventListener('turbo:load', initializepublicSidebar); 
});
