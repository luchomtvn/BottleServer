% rebase('base.tpl')

<!--Main div to insert in base-->
<div id="main_div_module" class="container main_container">
    <!-- Send specific serial div-->
    <div id="specific_serial" class="container padding_top30">
        <div class="col-xs-2">
          <label class="control-label">Send by Serial: </label>
        </div>
        <div class="col-xs-6">
          <input id="send_serial_input" class="form-control" type="text" placeholder="data to send">
        </div>
        <div class="col-xs-2">
            <button id="send_serial_button" class="btn btn-primary">Send</button>
        </div>
    </div>
    <!-- Active listener UART and disable it-->
    <div id="uart_state" class="container padding_top20">
        <div class="col-xs-2">
          <label class="control-label">Uart state: </label>
        </div>
        <div class="col-xs-6">
          <div class="btn-group">
              <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                State <span class="caret"></span>
              </button>
              <ul class="dropdown-menu">
                  <li>
                      <a class="uart_connection" value="connected" href="#">Connected</a>
                  </li>
                  <li>
                      <a class="uart_connection" value="disconnected" href="#">Disconnected</a>
                  </li>
              </ul>
          </div>
        </div>
    </div>
    <!-- Engine measurement value div -->
    <div id="engine_value" class="container padding_top20">
        <div class="col-xs-2">
            <label class="control-label">Sensor measurement: </label>
        </div>
        <div class="col-xs-2">
            <button type="button" class="btn btn-primary send_serial" value="GDIx0">Get value</button>
        </div>
    </div>
    <!-- Engine status div -->
    <div id="engine_status" class="container padding_top20">
        <div class="col-xs-2">
            <label class="control-label">Engine Status: </label>
        </div>
        <div class="col-xs-2">
            <button type="button" class="btn btn-success send_serial" value="PWM">On</button>
        </div>
        <div class="col-xs-2">
            <button type="button" class="btn btn-danger send_serial" value="NTP">Off</button>
        </div>
    </div>
    <!-- Engine gain div -->
    <div id="engine_gain" class="container padding_top20">
        <div class="col-xs-2">
            <label class="control-label">Engine Gain: </label>
        </div>
        <div class="col-xs-4">
            <div class="btn-group">
                <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Gain <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li><a class="send_serial" value="SGAx0" href="#">0</a></li>
                    <li><a class="send_serial" value="SGAx1" href="#">2</a></li>
                    <li><a class="send_serial" value="SGAx2" href="#">4</a></li>
                    <li><a class="send_serial" value="SGAx3" href="#">8</a></li>
                    <li><a class="send_serial" value="SGAx4" href="#">16</a></li>
                    <li><a class="send_serial" value="SGAx5" href="#">32</a></li>
                    <li><a class="send_serial" value="SGAx6" href="#">64</a></li>
                    <li><a class="send_serial" value="SGAx7" href="#">128</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- Low power div-->
    <div id="low_power" class="container padding_top20">
        <div class="col-xs-2">
            <label class="control-label">Low Power Mode: </label>
        </div>
        <div class="col-xs-2">
            <button type="button" class="btn btn-success send_serial" value="SLP">SLEEP</button>
        </div>
        <div class="col-xs-2">
            <button type="button" class="btn btn-danger send_serial" value="W">WAKE UP</button>
        </div>
    </div>
<div id="set_interval" class="container padding_top20">
        <div class="col-xs-2">
            <label class="control-label">Set mesuring interval: </label>
        </div>
        <div class="col-xs-2">
        Start: <input type="time" id="start_interval" min="00:00" max="23:59"><br>
        </div>
        <div class="col-xs-2">
        End: <input type="time" id="end_interval" min="00:00" max="23:59"><br>
        </div>
        <button id="set_interval_button" class="btn btn-primary">Set</button>

</div>

<!--Script when send a specific value-->
<script>

$("#set_interval_button").click(function(e){
    e.preventDefault();
    //Post with the button

    $.ajax({
        url: '/set_interval',
        data: 
        {
            start: $('#start_interval').val(),
            end:   $('#end_interval').val()
        },
        datatype: "json",
        cache:false, type: 'POST'
    });
});

$("#send_serial_button").click(function(e){
    e.preventDefault();
    //Post with the button
    $.ajax({
        url: '/send_serial/' + $("#send_serial_input").val(),
        cache:false, type: 'POST'
    });
});

/*
$("#send_serial_button").click(function(e){
    e.preventDefault();
    //Post with the button
    $.ajax({
        url: '/papo',
        cache:false,
        type: 'POST',
        data: {
            start: $('#start').val(),
            end:  $('#end').val()
        }
    });
});*/
</script>

<!--Script to connect/disconnect UART-->
<script>
$(".uart_connection").click(function(e){
    e.preventDefault();
    //Post to connect
    $.ajax({
        url: '/uart_state/' + $(this).attr("value"),
        cache:false, type: 'POST'
    });
});
</script>

<!--Script to send value of button by serial-->
<script>
$(".send_serial").click(function(e){
    e.preventDefault();
    //Post to connect
    $.ajax({
        url: '/send_serial/' + $(this).attr("value"),
        cache:false, type: 'POST'
    });
});
</script>