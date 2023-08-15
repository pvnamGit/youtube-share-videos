import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', function() {
  let body = document.querySelector('body');
  let userId = body.getAttribute('data-user-id');

  if (userId) {
    consumer.subscriptions.create({ channel: "NotificationsChannel", user_id: userId }, {
      connected() {
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        alert(`${data.user_name} shared a new video: ${data.video_title}`);
      }
    });
  }
});

