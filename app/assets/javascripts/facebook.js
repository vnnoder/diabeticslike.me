function invite_fb_friend() {
    FB.ui({
        method: 'send',
        name: 'Diabetes like me',
        link: 'http://www.diabeticslike.me/',
        description: "Track your blood level sugar and compare with your friends"
    });
}

function drawChart() {
    var chartData = buildTodayData(userGlucoseData, currentUserGlucoseData);
    // Create and draw the visualization.
    var chart = new google.visualization.ScatterChart(
        document.getElementById('glucose_chart'));
    chart.draw(chartData, {title: 'Glucose Level',
            "hAxis.viewWindowMode": "maximized",
            lineWidth: 1}
    );

}

function buildGaugeAverageData(){
    var data = google.visualization.arrayToDataTable([
        ['Label', 'Value'],
        ['Average', average]
        //,['Variance', variance]
    ]);
    return data;
}

function drawGaugeAverage() {
    var data = buildGaugeAverageData();
    var options = {
        width: 120, height: 120,
        max: 300,
        redFrom: 150, redTo: 300,
        yellowFrom:100, yellowTo: 150,
        minorTicks: 5
    };

    var chart = new google.visualization.Gauge(document.getElementById('glucose_gauge_average'));
    chart.draw(data, options);
}

function buildGaugeVarianceData(){
    var data = google.visualization.arrayToDataTable([
        ['Label', 'Value'],
        ['Variance', variance]
        //,['Variance', variance]
    ]);
    return data;
}

function drawGaugeVariance() {
    var data = buildGaugeVarianceData();
    var options = {
        width: 120, height: 120,
        max: 100,
        redFrom: 50, redTo: 100,
        yellowFrom:30, yellowTo: 50,
        minorTicks: 5
    };

    var chart = new google.visualization.Gauge(document.getElementById('glucose_gauge_variance'));
    chart.draw(data, options);
}
