const ctx = document.getElementById('mChart');
              
new Chart(ctx, {
  type: 'line',
  data: {
    labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo'],
    datasets: [{
      label: '# of Votes',
      data: [74, 200, 50, 25,175],
      borderWidth: 1,
      backgroundColor:'#F7B32B',
    }]
  },
  options: {
    scales: {
      y: {
        beginAtZero: true
      }
    }
  }
});