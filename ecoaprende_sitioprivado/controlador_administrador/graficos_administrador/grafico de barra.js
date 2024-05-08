// setup 
const data = {
    labels: ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes'],
    datasets: [{
      label: 'Libros vendidos mensualmente',
      data: [12, 11, 9, 15, 20, 9],
      backgroundColor:'#FF5C77',
    }]
  };

  // config 
  const config = {
    type: 'bar',
    data,
    options: {
        maintainAspectRatio: false,
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  };

  // render init block
  const myChart = new Chart(
    document.getElementById('myChart'),
    config
  );

  // Instantly assign Chart.js version
  const chartVersion = document.getElementById('chartVersion');
  chartVersion.innerText = Chart.version;