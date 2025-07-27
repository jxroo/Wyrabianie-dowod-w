window.addEventListener('message', function(event) {
  if (event.data.action === 'show') {
    document.getElementById('firstName').innerText = event.data.data.first;
    document.getElementById('lastName').innerText = event.data.data.last;
    document.getElementById('dob').innerText = event.data.data.dob;
    document.getElementById('nationality').innerText = event.data.data.nationality;

    const card = document.getElementById('idCard');
    card.classList.add('show');

    setTimeout(() => {
      card.classList.remove('show');
    }, 5000);
  }
});