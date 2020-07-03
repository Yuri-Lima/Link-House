<div id="readme" class="Box md js-code-block-container Box--responsive">
    <div class="Box-header d-flex flex-items-center flex-justify-between bg-white border-bottom-0">
      <h2 class="Box-title pr-3">
        README.md
      </h2>
    </div>
      <div class="Box-body px-5 pb-5">
        <article class="markdown-body entry-content container-lg" itemprop="text"><h1></svg></a>Homefi AX</h1>
<p><h3>The project started in 2014 was created with the intention of providing access to home automation to the average family income population.</h3>
<p>The Homefi module was created to be easily installed by users with little knowledge in home electronics, requiring only the connection of little wires for the system to be installed. The Homefi project was cancelled around at 2016 after the launch of the Chinese module called Sonoff which basically does the same service that Homefo AX would do.(<a href="https://sonoff.tech/" rel="nofollow">www.sonoff.tech/</a>) 
<h2><a id="user-content-hardware" class="anchor" aria-hidden="true" href="#hardware"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Hardware</h2>
<ul>
<li>ESP8266 2.4Ghz board from espressif;</li>
<li>Solid States Relays;</li>
<li>100 16v SMD Capacitors;</li>
<li>Hi-Link Imput 240Vac to 5Vdc/3w as Power Suply;</li>
<li>BC 846 Transistor;</li>
<li>DHT11 as Temperature Sensor;</li>
<li>Varistor and Inductor as protection of the circuit;</li>
<li>General conectors.;</li>
</ul>
<img src=“https://github.com/KrisKasprzak/ILI9341_t3_controls 59”>
<h2><a id="user-content-instalation" class="anchor" aria-hidden="true" href="#instalation"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Instalation</h2>
<p>Just install in your Arduino IDE as a normal library. Download the ZIP file, go to <strong>sketch</strong> -&gt; <strong>include library</strong> -&gt; <strong>add library .ZIP</strong> and point to the Decabot.ZIP.</p>
<h2><a id="user-content-basic-commands" class="anchor" aria-hidden="true" href="#basic-commands"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Basic commands</h2>
<p>To use the library you must declare your Decabot object:</p>
<pre><code>#include &lt;Decabot.h&gt;
Decabot robot(4);
void setup() {
  Serial.begin(9600);
  robot.boot();           //initialize Decabot
}
</code></pre>
<p>The parameter number in the object (in the example, 4) reffers to the delay time in each motor step. A safe number is 4. Higher delay will make the robot to walk slowly. Lower delay will make it run faster, but the 28BYJ-48 probabily will not run with a delay less than 3. Serial.begin on setup is optional, but it will show the telemetry messages from the robot.</p>
<p>To move forward, you can use:</p>
<pre><code>robot.forward(10);
</code></pre>
<p>To draw a 10cm square, you can use:</p>
<pre><code>for(int i=1;i&lt;=4;i++){  //repeat forward and left 4 times to draw a square
    robot.forward(10);    //move forward 10 centimeters
    robot.left(90);       //turn left 90°
}
</code></pre>
<h2><a id="user-content-code-domino" class="anchor" aria-hidden="true" href="#code-domino"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Code Domino</h2>
<p>The best way to play with your Decabot is using Code Domino language. To use it by typing:</p>
<pre><code>#include &lt;Decabot.h&gt;
Decabot robot(2); //create object Decabot with 4 millis between motor steps
void setup() {
  Serial.begin(9600);
  robot.boot();           //initialize Decabot
  robot.codeDomino("[square]X4FLYO"); //draw a square
  robot.run();
}

void loop() {
  robot.update();         //update state of Code Domino machine
}
</code></pre>
<p>Where the codeDomino() function must contain the String code. Commands are represented by letters, and parameters are numbers:</p>
<ul>
<li><strong>[ ]</strong> text between simply brackets is the Code Domino's name, and is ignored by the Decabot;</li>
<li><strong>X4</strong> repeats the following commands 4 times;</li>
<li><strong>F</strong> goes forward. As it doesn't have a numeric parameter, the standard value is 10cm;</li>
<li><strong>L</strong> goes left. As it doesn't have a numeric parameter, the standard value is 90°;</li>
<li><strong>Y</strong> ends the repeat loop;</li>
<li><strong>O</strong> ends the code.</li>
</ul>
<p>A list of Code Domino commands can be found at documentation folder.</p>
<h3><a id="user-content-send-cd-codes-through-serial" class="anchor" aria-hidden="true" href="#send-cd-codes-through-serial"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Send CD codes through Serial</h3>
<p>You can send Code Domino commands through Serial, by including this serialEvent() function after the loop():</p>
<pre><code>void serialEvent() {      //allows the robot to receive data from Serial
  while (Serial.available()) {
    robot.inputSerial((char)Serial.read());
  }
}
</code></pre>
<p>See the documentation for other ways to run Code Domino on your Decabot!</p>
</article>
      </div>
  </div>
