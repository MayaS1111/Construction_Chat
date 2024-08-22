// Utility functions
function toggleSidebar(sidebarId, stateKey) {
  var sidebar = document.getElementById(sidebarId);
  if (sidebar) {
    var isClosed = sidebar.classList.contains('closed');
    if (isClosed) {
      sidebar.classList.remove('closed');
      localStorage.setItem(stateKey, 'open');
    } else {
      sidebar.classList.add('closed');
      localStorage.setItem(stateKey, 'closed');
    }
  } else {
    console.error(`Element with id "${sidebarId}" not found.`);
  }
}

function loadSidebarState(sidebarId, stateKey) {
  var sidebar = document.getElementById(sidebarId);
  var sidebarState = localStorage.getItem(stateKey);
  if (sidebar) {
    if (sidebarState === 'closed') {
      sidebar.classList.add('closed');
    } else {
      sidebar.classList.remove('closed');
    }
  }
}

function initializeSidebar(sidebarId, toggleButtonId, stateKey) {
  loadSidebarState(sidebarId, stateKey);

  var toggleButton = document.getElementById(toggleButtonId);
  if (toggleButton) {
    toggleButton.addEventListener('click', function() {
      toggleSidebar(sidebarId, stateKey);
    });
  }
}

// Initialization function
function initializeSidebars() {
  initializeSidebar('project_col_box', 'project_col_toggle', 'projectSidebarState');
  initializeSidebar('chat_col_box_private', 'chat_col_toggle_private', 'chatSidebarStatePrivate');
  initializeSidebar('chat_column_box_public', 'chat_col_toggle_public', 'chatSidebarStatePublic');
}

// Event listeners
document.addEventListener('DOMContentLoaded', initializeSidebars);
document.addEventListener('turbolinks:load', initializeSidebars); 
document.addEventListener('turbo:load', initializeSidebars);
