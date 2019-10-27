#encoding: utf-8
require 'rspec'
require 'asciimath'

TEST_CASES = {
    'x+b/(2a)<+-sqrt((b^2)/(4a^2)-c/a)' =>
    {
        :mathml => '<math><mi>x</mi><mo>+</mo><mfrac><mi>b</mi><mrow><mn>2</mn><mi>a</mi></mrow></mfrac><mo>&lt;</mo><mo>&#xB1;</mo><msqrt><mrow><mfrac><msup><mi>b</mi><mn>2</mn></msup><mrow><mn>4</mn><msup><mi>a</mi><mn>2</mn></msup></mrow></mfrac><mo>&#x2212;</mo><mfrac><mi>c</mi><mi>a</mi></mfrac></mrow></msqrt></math>',
        :html => nil,
    },
    'a^2 + b^2 = c^2' =>
    {
        :mathml => '<math><msup><mi>a</mi><mn>2</mn></msup><mo>+</mo><msup><mi>b</mi><mn>2</mn></msup><mo>=</mo><msup><mi>c</mi><mn>2</mn></msup></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-identifier">a</span><span class="math-subsup"><span class="math-smaller"><span class="math-number">2</span></span><span class="math-smaller">&#x200D;</span></span><span class="math-operator">+</span><span class="math-identifier">b</span><span class="math-subsup"><span class="math-smaller"><span class="math-number">2</span></span><span class="math-smaller">&#x200D;</span></span><span class="math-operator">=</span><span class="math-identifier">c</span><span class="math-subsup"><span class="math-smaller"><span class="math-number">2</span></span><span class="math-smaller">&#x200D;</span></span></span></span>',
    },
    'x = (-b+-sqrt(b^2-4ac))/(2a)' =>
    {
        :mathml => '<math><mi>x</mi><mo>=</mo><mfrac><mrow><mo>&#x2212;</mo><mi>b</mi><mo>&#xB1;</mo><msqrt><mrow><msup><mi>b</mi><mn>2</mn></msup><mn>-4</mn><mi>a</mi><mi>c</mi></mrow></msqrt></mrow><mrow><mn>2</mn><mi>a</mi></mrow></mfrac></math>',
        :html => nil
    },
    'm = (y_2 - y_1)/(x_2 - x_1) = (Deltay)/(Deltax)' =>
    {
        :mathml => '<math><mi>m</mi><mo>=</mo><mfrac><mrow><msub><mi>y</mi><mn>2</mn></msub><mo>&#x2212;</mo><msub><mi>y</mi><mn>1</mn></msub></mrow><mrow><msub><mi>x</mi><mn>2</mn></msub><mo>&#x2212;</mo><msub><mi>x</mi><mn>1</mn></msub></mrow></mfrac><mo>=</mo><mfrac><mrow><mo>&#x394;</mo><mi>y</mi></mrow><mrow><mo>&#x394;</mo><mi>x</mi></mrow></mfrac></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-identifier">m</span><span class="math-operator">=</span><span class="math-blank">&#x200D;</span><span class="math-fraction"><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-identifier">y</span><span class="math-subsup"><span class="math-smaller">&#x200D;</span><span class="math-smaller"><span class="math-number">2</span></span></span><span class="math-operator">&#x2212;</span><span class="math-identifier">y</span><span class="math-subsup"><span class="math-smaller">&#x200D;</span><span class="math-smaller"><span class="math-number">1</span></span></span></span></span></span></span></span><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-identifier">x</span><span class="math-subsup"><span class="math-smaller">&#x200D;</span><span class="math-smaller"><span class="math-number">2</span></span></span><span class="math-operator">&#x2212;</span><span class="math-identifier">x</span><span class="math-subsup"><span class="math-smaller">&#x200D;</span><span class="math-smaller"><span class="math-number">1</span></span></span></span></span></span></span></span></span><span class="math-operator">=</span><span class="math-blank">&#x200D;</span><span class="math-fraction"><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-operator">&#x394;</span><span class="math-identifier">y</span></span></span></span></span></span><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-operator">&#x394;</span><span class="math-identifier">x</span></span></span></span></span></span></span></span></span>'
    },
    'f\'(x) = lim_(Deltax->0)(f(x+Deltax)-f(x))/(Deltax)' =>
    {
        :mathml => '<math><mi>f</mi><mo>&#x2032;</mo><mfenced open="(" close=")"><mi>x</mi></mfenced><mo>=</mo><munder><mo>lim</mo><mrow><mo>&#x394;</mo><mi>x</mi><mo>&#x2192;</mo><mn>0</mn></mrow></munder><mfrac><mrow><mi>f</mi><mfenced open="(" close=")"><mrow><mi>x</mi><mo>+</mo><mo>&#x394;</mo><mi>x</mi></mrow></mfenced><mo>&#x2212;</mo><mi>f</mi><mfenced open="(" close=")"><mi>x</mi></mfenced></mrow><mrow><mo>&#x394;</mo><mi>x</mi></mrow></mfrac></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-identifier">f</span><span class="math-operator">&#x2032;</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">x</span></span><span class="math-brace">)</span></span><span class="math-operator">=</span><span class="math-blank">&#x200D;</span><span class="math-underover"><span class="math-smaller"><span class="math-blank">&#x200D;</span></span><span class="math-operator">lim</span><span class="math-smaller"><span class="math-row"><span class="math-operator">&#x394;</span><span class="math-identifier">x</span><span class="math-operator">&#x2192;</span><span class="math-number">0</span></span></span></span><span class="math-blank">&#x200D;</span><span class="math-fraction"><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-identifier">f</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">x</span><span class="math-operator">+</span><span class="math-operator">&#x394;</span><span class="math-identifier">x</span></span><span class="math-brace">)</span></span><span class="math-operator">&#x2212;</span><span class="math-identifier">f</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">x</span></span><span class="math-brace">)</span></span></span></span></span></span></span><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-operator">&#x394;</span><span class="math-identifier">x</span></span></span></span></span></span></span></span></span>'
    },
    'd/dx [x^n] = nx^(n - 1)' =>
    {
        :mathml => '<math><mfrac><mi>d</mi><mi>dx</mi></mfrac><mfenced open="[" close="]"><msup><mi>x</mi><mi>n</mi></msup></mfenced><mo>=</mo><mi>n</mi><msup><mi>x</mi><mrow><mi>n</mi><mo>&#x2212;</mo><mn>1</mn></mrow></msup></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-blank">&#x200D;</span><span class="math-fraction"><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-identifier">d</span></span></span></span></span><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-identifier">dx</span></span></span></span></span></span><span class="math-row"><span class="math-brace">[</span><span class="math-row"><span class="math-identifier">x</span><span class="math-subsup"><span class="math-smaller"><span class="math-identifier">n</span></span><span class="math-smaller">&#x200D;</span></span></span><span class="math-brace">]</span></span><span class="math-operator">=</span><span class="math-identifier">n</span><span class="math-identifier">x</span><span class="math-subsup"><span class="math-smaller"><span class="math-row"><span class="math-identifier">n</span><span class="math-operator">&#x2212;</span><span class="math-number">1</span></span></span><span class="math-smaller">&#x200D;</span></span></span></span>'
    },
    'int_a^b f(x) dx = [F(x)]_a^b = F(b) - F(a)' =>
    {
        :mathml => '<math><msubsup><mo>&#x222B;</mo><mi>a</mi><mi>b</mi></msubsup><mi>f</mi><mfenced open="(" close=")"><mi>x</mi></mfenced><mi>dx</mi><mo>=</mo><msubsup><mfenced open="[" close="]"><mrow><mi>F</mi><mfenced open="(" close=")"><mi>x</mi></mfenced></mrow></mfenced><mi>a</mi><mi>b</mi></msubsup><mo>=</mo><mi>F</mi><mfenced open="(" close=")"><mi>b</mi></mfenced><mo>&#x2212;</mo><mi>F</mi><mfenced open="(" close=")"><mi>a</mi></mfenced></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-operator">&#x222B;</span><span class="math-subsup"><span class="math-smaller"><span class="math-identifier">b</span></span><span class="math-smaller"><span class="math-identifier">a</span></span></span><span class="math-identifier">f</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">x</span></span><span class="math-brace">)</span></span><span class="math-identifier">dx</span><span class="math-operator">=</span><span class="math-row"><span class="math-brace">[</span><span class="math-row"><span class="math-identifier">F</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">x</span></span><span class="math-brace">)</span></span></span><span class="math-brace">]</span></span><span class="math-subsup"><span class="math-smaller"><span class="math-identifier">b</span></span><span class="math-smaller"><span class="math-identifier">a</span></span></span><span class="math-operator">=</span><span class="math-identifier">F</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">b</span></span><span class="math-brace">)</span></span><span class="math-operator">&#x2212;</span><span class="math-identifier">F</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">a</span></span><span class="math-brace">)</span></span></span></span>'
    },
    'int_a^b f(x) dx = f(c)(b - a)' =>
    {
        :mathml => '<math><msubsup><mo>&#x222B;</mo><mi>a</mi><mi>b</mi></msubsup><mi>f</mi><mfenced open="(" close=")"><mi>x</mi></mfenced><mi>dx</mi><mo>=</mo><mi>f</mi><mfenced open="(" close=")"><mi>c</mi></mfenced><mfenced open="(" close=")"><mrow><mi>b</mi><mo>&#x2212;</mo><mi>a</mi></mrow></mfenced></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-operator">&#x222B;</span><span class="math-subsup"><span class="math-smaller"><span class="math-identifier">b</span></span><span class="math-smaller"><span class="math-identifier">a</span></span></span><span class="math-identifier">f</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">x</span></span><span class="math-brace">)</span></span><span class="math-identifier">dx</span><span class="math-operator">=</span><span class="math-identifier">f</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">c</span></span><span class="math-brace">)</span></span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">b</span><span class="math-operator">&#x2212;</span><span class="math-identifier">a</span></span><span class="math-brace">)</span></span></span></span>'
    },
    'ax^2 + bx + c = 0' =>
    {
        :mathml => '<math><mi>a</mi><msup><mi>x</mi><mn>2</mn></msup><mo>+</mo><mi>b</mi><mi>x</mi><mo>+</mo><mi>c</mi><mo>=</mo><mn>0</mn></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-identifier">a</span><span class="math-identifier">x</span><span class="math-subsup"><span class="math-smaller"><span class="math-number">2</span></span><span class="math-smaller">&#x200D;</span></span><span class="math-operator">+</span><span class="math-identifier">b</span><span class="math-identifier">x</span><span class="math-operator">+</span><span class="math-identifier">c</span><span class="math-operator">=</span><span class="math-number">0</span></span></span>'
    },
    '"average value"=1/(b-a) int_a^b f(x) dx' =>
    {
        :mathml => '<math><mtext>average value</mtext><mo>=</mo><mfrac><mn>1</mn><mrow><mi>b</mi><mo>&#x2212;</mo><mi>a</mi></mrow></mfrac><msubsup><mo>&#x222B;</mo><mi>a</mi><mi>b</mi></msubsup><mi>f</mi><mfenced open="(" close=")"><mi>x</mi></mfenced><mi>dx</mi></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-text">average value</span><span class="math-operator">=</span><span class="math-blank">&#x200D;</span><span class="math-fraction"><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-number">1</span></span></span></span></span><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-identifier">b</span><span class="math-operator">&#x2212;</span><span class="math-identifier">a</span></span></span></span></span></span></span><span class="math-operator">&#x222B;</span><span class="math-subsup"><span class="math-smaller"><span class="math-identifier">b</span></span><span class="math-smaller"><span class="math-identifier">a</span></span></span><span class="math-identifier">f</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">x</span></span><span class="math-brace">)</span></span><span class="math-identifier">dx</span></span></span>'
    },
    'd/dx[int_a^x f(t) dt] = f(x)' =>
    {
        :mathml => '<math><mfrac><mi>d</mi><mi>dx</mi></mfrac><mfenced open="[" close="]"><mrow><msubsup><mo>&#x222B;</mo><mi>a</mi><mi>x</mi></msubsup><mi>f</mi><mfenced open="(" close=")"><mi>t</mi></mfenced><mi>dt</mi></mrow></mfenced><mo>=</mo><mi>f</mi><mfenced open="(" close=")"><mi>x</mi></mfenced></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-blank">&#x200D;</span><span class="math-fraction"><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-identifier">d</span></span></span></span></span><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-identifier">dx</span></span></span></span></span></span><span class="math-row"><span class="math-brace">[</span><span class="math-row"><span class="math-operator">&#x222B;</span><span class="math-subsup"><span class="math-smaller"><span class="math-identifier">x</span></span><span class="math-smaller"><span class="math-identifier">a</span></span></span><span class="math-identifier">f</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">t</span></span><span class="math-brace">)</span></span><span class="math-identifier">dt</span></span><span class="math-brace">]</span></span><span class="math-operator">=</span><span class="math-identifier">f</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">x</span></span><span class="math-brace">)</span></span></span></span>'
    },
    'hat(ab) bar(xy) ul(A) vec(v)' =>
    {
        :mathml => '<math><mover><mrow><mi>a</mi><mi>b</mi></mrow><mo>^</mo></mover><mover><mrow><mi>x</mi><mi>y</mi></mrow><mo>&#xAF;</mo></mover><munder><mi>A</mi><mo>_</mo></munder><mover><mi>v</mi><mo>&#x2192;</mo></mover></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-blank">&#x200D;</span><span class="math-underover"><span class="math-smaller"><span class="math-operator">^</span></span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">a</span><span class="math-identifier">b</span></span><span class="math-brace">)</span></span><span class="math-smaller"><span class="math-blank">&#x200D;</span></span></span><span class="math-blank">&#x200D;</span><span class="math-underover"><span class="math-smaller"><span class="math-operator">&#xAF;</span></span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">x</span><span class="math-identifier">y</span></span><span class="math-brace">)</span></span><span class="math-smaller"><span class="math-blank">&#x200D;</span></span></span><span class="math-blank">&#x200D;</span><span class="math-underover"><span class="math-smaller"><span class="math-blank">&#x200D;</span></span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">A</span></span><span class="math-brace">)</span></span><span class="math-smaller"><span class="math-operator">_</span></span></span><span class="math-blank">&#x200D;</span><span class="math-underover"><span class="math-smaller"><span class="math-operator">&#x2192;</span></span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">v</span></span><span class="math-brace">)</span></span><span class="math-smaller"><span class="math-blank">&#x200D;</span></span></span></span></span>'
    },
    'z_12^34' =>
    {
        :mathml => '<math><msubsup><mi>z</mi><mn>12</mn><mn>34</mn></msubsup></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-identifier">z</span><span class="math-subsup"><span class="math-smaller"><span class="math-number">34</span></span><span class="math-smaller"><span class="math-number">12</span></span></span></span></span>'
    },
    'lim_(x->c)(f(x)-f(c))/(x-c)' =>
    {
        :mathml => '<math><munder><mo>lim</mo><mrow><mi>x</mi><mo>&#x2192;</mo><mi>c</mi></mrow></munder><mfrac><mrow><mi>f</mi><mfenced open="(" close=")"><mi>x</mi></mfenced><mo>&#x2212;</mo><mi>f</mi><mfenced open="(" close=")"><mi>c</mi></mfenced></mrow><mrow><mi>x</mi><mo>&#x2212;</mo><mi>c</mi></mrow></mfrac></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-blank">&#x200D;</span><span class="math-underover"><span class="math-smaller"><span class="math-blank">&#x200D;</span></span><span class="math-operator">lim</span><span class="math-smaller"><span class="math-row"><span class="math-identifier">x</span><span class="math-operator">&#x2192;</span><span class="math-identifier">c</span></span></span></span><span class="math-blank">&#x200D;</span><span class="math-fraction"><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-identifier">f</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">x</span></span><span class="math-brace">)</span></span><span class="math-operator">&#x2212;</span><span class="math-identifier">f</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">c</span></span><span class="math-brace">)</span></span></span></span></span></span></span><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-identifier">x</span><span class="math-operator">&#x2212;</span><span class="math-identifier">c</span></span></span></span></span></span></span></span></span>'
    },
    'int_0^(pi/2) g(x) dx' =>
    {
        :mathml => '<math><msubsup><mo>&#x222B;</mo><mn>0</mn><mfrac><mi>&#x3C0;</mi><mn>2</mn></mfrac></msubsup><mi>g</mi><mfenced open="(" close=")"><mi>x</mi></mfenced><mi>dx</mi></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-operator">&#x222B;</span><span class="math-subsup"><span class="math-smaller"><span class="math-row"><span class="math-blank">&#x200D;</span><span class="math-fraction"><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-identifier">&#x3C0;</span></span></span></span></span><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-number">2</span></span></span></span></span></span></span></span><span class="math-smaller"><span class="math-number">0</span></span></span><span class="math-identifier">g</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">x</span></span><span class="math-brace">)</span></span><span class="math-identifier">dx</span></span></span>'
    },
    'sum_(n=0)^oo a_n' =>
    {
        :mathml => '<math><munderover><mo>&#x2211;</mo><mrow><mi>n</mi><mo>=</mo><mn>0</mn></mrow><mo>&#x221E;</mo></munderover><msub><mi>a</mi><mi>n</mi></msub></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-blank">&#x200D;</span><span class="math-underover"><span class="math-smaller"><span class="math-operator">&#x221E;</span></span><span class="math-operator">&#x2211;</span><span class="math-smaller"><span class="math-row"><span class="math-identifier">n</span><span class="math-operator">=</span><span class="math-number">0</span></span></span></span><span class="math-identifier">a</span><span class="math-subsup"><span class="math-smaller">&#x200D;</span><span class="math-smaller"><span class="math-identifier">n</span></span></span></span></span>'
    },
    '((1,2,3),(4,5,6),(7,8,9))' =>
    {
        :mathml => '<math><mfenced open="(" close=")"><mtable><mtr><mtd><mn>1</mn></mtd><mtd><mn>2</mn></mtd><mtd><mn>3</mn></mtd></mtr><mtr><mtd><mn>4</mn></mtd><mtd><mn>5</mn></mtd><mtd><mn>6</mn></mtd></mtr><mtr><mtd><mn>7</mn></mtd><mtd><mn>8</mn></mtd><mtd><mn>9</mn></mtd></mtr></mtable></mfenced></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-row"><span class="math-brace" style="font-size: 300%;">(</span><span class="math-matrix" style="grid-template-columns:repeat(3,1fr);grid-template-rows:repeat(3,1fr);"><span class="math-row"><span class="math-number">1</span></span><span class="math-row"><span class="math-number">2</span></span><span class="math-row"><span class="math-number">3</span></span><span class="math-row"><span class="math-number">4</span></span><span class="math-row"><span class="math-number">5</span></span><span class="math-row"><span class="math-number">6</span></span><span class="math-row"><span class="math-number">7</span></span><span class="math-row"><span class="math-number">8</span></span><span class="math-row"><span class="math-number">9</span></span></span><span class="math-brace" style="font-size: 300%;">)</span></span></span></span>'
    },
    '|(a,b),(c,d)|=ad-bc' =>
    {
        :mathml => '<math><mfenced open="|" close="|"><mtable><mtr><mtd><mi>a</mi></mtd><mtd><mi>b</mi></mtd></mtr><mtr><mtd><mi>c</mi></mtd><mtd><mi>d</mi></mtd></mtr></mtable></mfenced><mo>=</mo><mi>a</mi><mi>d</mi><mo>&#x2212;</mo><mi>b</mi><mi>c</mi></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-row"><span class="math-brace" style="font-size: 200%;">|</span><span class="math-matrix" style="grid-template-columns:repeat(2,1fr);grid-template-rows:repeat(2,1fr);"><span class="math-row"><span class="math-identifier">a</span></span><span class="math-row"><span class="math-identifier">b</span></span><span class="math-row"><span class="math-identifier">c</span></span><span class="math-row"><span class="math-identifier">d</span></span></span><span class="math-brace" style="font-size: 200%;">|</span></span><span class="math-operator">=</span><span class="math-identifier">a</span><span class="math-identifier">d</span><span class="math-operator">&#x2212;</span><span class="math-identifier">b</span><span class="math-identifier">c</span></span></span>'
    },
    '((a_(11), cdots , a_(1n)),(vdots, ddots, vdots),(a_(m1), cdots , a_(mn)))' =>
    {
        :mathml => '<math><mfenced open="(" close=")"><mtable><mtr><mtd><msub><mi>a</mi><mn>11</mn></msub></mtd><mtd><mo>&#x22EF;</mo></mtd><mtd><msub><mi>a</mi><mrow><mn>1</mn><mi>n</mi></mrow></msub></mtd></mtr><mtr><mtd><mo>&#x22EE;</mo></mtd><mtd><mo>&#x22F1;</mo></mtd><mtd><mo>&#x22EE;</mo></mtd></mtr><mtr><mtd><msub><mi>a</mi><mrow><mi>m</mi><mn>1</mn></mrow></msub></mtd><mtd><mo>&#x22EF;</mo></mtd><mtd><msub><mi>a</mi><mrow><mi>m</mi><mi>n</mi></mrow></msub></mtd></mtr></mtable></mfenced></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-row"><span class="math-brace" style="font-size: 300%;">(</span><span class="math-matrix" style="grid-template-columns:repeat(3,1fr);grid-template-rows:repeat(3,1fr);"><span class="math-row"><span class="math-identifier">a</span><span class="math-subsup"><span class="math-smaller">&#x200D;</span><span class="math-smaller"><span class="math-row"><span class="math-number">11</span></span></span></span></span><span class="math-row"><span class="math-operator">&#x22EF;</span></span><span class="math-row"><span class="math-identifier">a</span><span class="math-subsup"><span class="math-smaller">&#x200D;</span><span class="math-smaller"><span class="math-row"><span class="math-number">1</span><span class="math-identifier">n</span></span></span></span></span><span class="math-row"><span class="math-operator">&#x22EE;</span></span><span class="math-row"><span class="math-operator">&#x22F1;</span></span><span class="math-row"><span class="math-operator">&#x22EE;</span></span><span class="math-row"><span class="math-identifier">a</span><span class="math-subsup"><span class="math-smaller">&#x200D;</span><span class="math-smaller"><span class="math-row"><span class="math-identifier">m</span><span class="math-number">1</span></span></span></span></span><span class="math-row"><span class="math-operator">&#x22EF;</span></span><span class="math-row"><span class="math-identifier">a</span><span class="math-subsup"><span class="math-smaller">&#x200D;</span><span class="math-smaller"><span class="math-row"><span class="math-identifier">m</span><span class="math-identifier">n</span></span></span></span></span></span><span class="math-brace" style="font-size: 300%;">)</span></span></span></span>'
    },
    'sum_(k=1)^n k = 1+2+ cdots +n=(n(n+1))/2' =>
    {
        :mathml => '<math><munderover><mo>&#x2211;</mo><mrow><mi>k</mi><mo>=</mo><mn>1</mn></mrow><mi>n</mi></munderover><mi>k</mi><mo>=</mo><mn>1</mn><mo>+</mo><mn>2</mn><mo>+</mo><mo>&#x22EF;</mo><mo>+</mo><mi>n</mi><mo>=</mo><mfrac><mrow><mi>n</mi><mfenced open="(" close=")"><mrow><mi>n</mi><mo>+</mo><mn>1</mn></mrow></mfenced></mrow><mn>2</mn></mfrac></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-blank">&#x200D;</span><span class="math-underover"><span class="math-smaller"><span class="math-identifier">n</span></span><span class="math-operator">&#x2211;</span><span class="math-smaller"><span class="math-row"><span class="math-identifier">k</span><span class="math-operator">=</span><span class="math-number">1</span></span></span></span><span class="math-identifier">k</span><span class="math-operator">=</span><span class="math-number">1</span><span class="math-operator">+</span><span class="math-number">2</span><span class="math-operator">+</span><span class="math-operator">&#x22EF;</span><span class="math-operator">+</span><span class="math-identifier">n</span><span class="math-operator">=</span><span class="math-blank">&#x200D;</span><span class="math-fraction"><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-identifier">n</span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">n</span><span class="math-operator">+</span><span class="math-number">1</span></span><span class="math-brace">)</span></span></span></span></span></span></span><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-number">2</span></span></span></span></span></span></span></span>'
    },
    '"Скорость"=("Расстояние")/("Время")' =>
    {
        :mathml => '<math><mtext>&#x421;&#x43A;&#x43E;&#x440;&#x43E;&#x441;&#x442;&#x44C;</mtext><mo>=</mo><mfrac><mtext>&#x420;&#x430;&#x441;&#x441;&#x442;&#x43E;&#x44F;&#x43D;&#x438;&#x435;</mtext><mtext>&#x412;&#x440;&#x435;&#x43C;&#x44F;</mtext></mfrac></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-text">&#x421;&#x43A;&#x43E;&#x440;&#x43E;&#x441;&#x442;&#x44C;</span><span class="math-operator">=</span><span class="math-blank">&#x200D;</span><span class="math-fraction"><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-text">&#x420;&#x430;&#x441;&#x441;&#x442;&#x43E;&#x44F;&#x43D;&#x438;&#x435;</span></span></span></span></span></span><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-text">&#x412;&#x440;&#x435;&#x43C;&#x44F;</span></span></span></span></span></span></span></span></span>'
    },
    'bb (a + b) + cc c = fr (d^n)' =>
    {
        :mathml => '<math><mstyle mathvariant="bold"><mrow><mi>a</mi><mo>+</mo><mi>b</mi></mrow></mstyle><mo>+</mo><mstyle mathvariant="script"><mi>c</mi></mstyle><mo>=</mo><mstyle mathvariant="fraktur"><msup><mi>d</mi><mi>n</mi></msup></mstyle></math>',
        :html => nil
    },
    'max()' =>
    {
        :mathml => '<math><mo>max</mo><mfenced open="(" close=")"></mfenced></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-operator">max</span><span class="math-row"><span class="math-brace">(</span><span class="math-brace">)</span></span></span></span>'
    },
    'text("foo")' => {
        :mathml => '<math><mtext>"foo"</mtext></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-text">"foo"</span></span></span>'
    },
    'ubrace(1 + 2) obrace(3 + 4' => {
        :mathml => '<math><munder><mrow><mn>1</mn><mo>+</mo><mn>2</mn></mrow><mo>&#x23DF;</mo></munder><mover><mrow><mn>3</mn><mo>+</mo><mn>4</mn></mrow><mo>&#x23DE;</mo></mover></math>'
    },
    "s'_i = {(- 1, if s_i > s_(i + 1)),( + 1, if s_i <= s_(i + 1)):}" => {
        :mathml => '<math><mi>s</mi><msub><mo>&#x2032;</mo><mi>i</mi></msub><mo>=</mo><mfenced open="{" close=""><mtable><mtr><mtd><mrow><mo>&#x2212;</mo><mn>1</mn></mrow></mtd><mtd><mrow><mo>if</mo><msub><mi>s</mi><mi>i</mi></msub><mo>&gt;</mo><msub><mi>s</mi><mrow><mi>i</mi><mo>+</mo><mn>1</mn></mrow></msub></mrow></mtd></mtr><mtr><mtd><mrow><mo>+</mo><mn>1</mn></mrow></mtd><mtd><mrow><mo>if</mo><msub><mi>s</mi><mi>i</mi></msub><mo>&#x2264;</mo><msub><mi>s</mi><mrow><mi>i</mi><mo>+</mo><mn>1</mn></mrow></msub></mrow></mtd></mtr></mtable></mfenced></math>'
    },
    "s'_i = {(, if s_i > s_(i + 1)),( + 1,):}" => {
        :mathml => '<math><mi>s</mi><msub><mo>&#x2032;</mo><mi>i</mi></msub><mo>=</mo><mfenced open="{" close=""><mtable><mtr><mtd></mtd><mtd><mrow><mo>if</mo><msub><mi>s</mi><mi>i</mi></msub><mo>&gt;</mo><msub><mi>s</mi><mrow><mi>i</mi><mo>+</mo><mn>1</mn></mrow></msub></mrow></mtd></mtr><mtr><mtd><mrow><mo>+</mo><mn>1</mn></mrow></mtd><mtd></mtd></mtr></mtable></mfenced></math>'
    },
    '{:(a,b),(c,d):}' => {
        :mathml => '<math><mtable><mtr><mtd><mi>a</mi></mtd><mtd><mi>b</mi></mtd></mtr><mtr><mtd><mi>c</mi></mtd><mtd><mi>d</mi></mtd></mtr></mtable></math>'
    },
    'overset (a + b) (c + d)' => {
        :mathml => '<math><mover><mrow><mi>c</mi><mo>+</mo><mi>d</mi></mrow><mrow><mi>a</mi><mo>+</mo><mi>b</mi></mrow></mover></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-blank">&#x200D;</span><span class="math-underover"><span class="math-smaller"><span class="math-row"><span class="math-identifier">a</span><span class="math-operator">+</span><span class="math-identifier">b</span></span></span><span class="math-row"><span class="math-brace">(</span><span class="math-row"><span class="math-identifier">c</span><span class="math-operator">+</span><span class="math-identifier">d</span></span><span class="math-brace">)</span></span><span class="math-smaller"><span class="math-blank">&#x200D;</span></span></span></span></span>'
    },
    'underset a b' => {
        :mathml => '<math><munder><mi>b</mi><mi>a</mi></munder></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-blank">&#x200D;</span><span class="math-underover"><span class="math-smaller"><span class="math-blank">&#x200D;</span></span><span class="math-identifier">b</span><span class="math-smaller"><span class="math-identifier">a</span></span></span></span></span>'
    },
    'sin a_c^b' => {
        :mathml => '<math><msubsup><mrow><mi>sin</mi><mi>a</mi></mrow><mi>c</mi><mi>b</mi></msubsup></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-row"><span class="math-identifier">sin</span><span class="math-identifier">a</span></span><span class="math-subsup"><span class="math-smaller"><span class="math-identifier">b</span></span><span class="math-smaller"><span class="math-identifier">c</span></span></span></span></span>'
    },
    'max a_c^b' => {
        :mathml => '<math><mo>max</mo><msubsup><mi>a</mi><mi>c</mi><mi>b</mi></msubsup></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-operator">max</span><span class="math-identifier">a</span><span class="math-subsup"><span class="math-smaller"><span class="math-identifier">b</span></span><span class="math-smaller"><span class="math-identifier">c</span></span></span></span></span>'
    },
    'norm a_c^b' => {
        :mathml => '<math><msubsup><mfenced open="&#x2225;" close="&#x2225;"><mi>a</mi></mfenced><mi>c</mi><mi>b</mi></msubsup></math>',
        :html => '<span class="math-inline"><span class="math-row"><span class="math-row"><span class="math-brace">&#x2225;</span><span class="math-identifier">a</span><span class="math-brace">&#x2225;</span></span><span class="math-subsup"><span class="math-smaller"><span class="math-identifier">b</span></span><span class="math-smaller"><span class="math-identifier">c</span></span></span></span></span>'
    }
}

version = RUBY_VERSION.split('.').map { |s| s.to_i }

if version[0] > 1 || version[1] > 8
  TEST_CASES['Скорость=(Расстояние)/(Время)'] = 
  {
    :mathml => '<math><mi>&#x421;</mi><mi>&#x43A;</mi><mi>&#x43E;</mi><mi>&#x440;</mi><mi>&#x43E;</mi><mi>&#x441;</mi><mi>&#x442;</mi><mi>&#x44C;</mi><mo>=</mo><mfrac><mrow><mi>&#x420;</mi><mi>&#x430;</mi><mi>&#x441;</mi><mi>&#x441;</mi><mi>&#x442;</mi><mi>&#x43E;</mi><mi>&#x44F;</mi><mi>&#x43D;</mi><mi>&#x438;</mi><mi>&#x435;</mi></mrow><mrow><mi>&#x412;</mi><mi>&#x440;</mi><mi>&#x435;</mi><mi>&#x43C;</mi><mi>&#x44F;</mi></mrow></mfrac></math>',
    :html => '<span class="math-inline"><span class="math-row"><span class="math-identifier">&#x421;</span><span class="math-identifier">&#x43A;</span><span class="math-identifier">&#x43E;</span><span class="math-identifier">&#x440;</span><span class="math-identifier">&#x43E;</span><span class="math-identifier">&#x441;</span><span class="math-identifier">&#x442;</span><span class="math-identifier">&#x44C;</span><span class="math-operator">=</span><span class="math-blank">&#x200D;</span><span class="math-fraction"><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-identifier">&#x420;</span><span class="math-identifier">&#x430;</span><span class="math-identifier">&#x441;</span><span class="math-identifier">&#x441;</span><span class="math-identifier">&#x442;</span><span class="math-identifier">&#x43E;</span><span class="math-identifier">&#x44F;</span><span class="math-identifier">&#x43D;</span><span class="math-identifier">&#x438;</span><span class="math-identifier">&#x435;</span></span></span></span></span></span><span class="math-fraction_row"><span class="math-fraction_cell"><span class="math-smaller"><span class="math-row"><span class="math-row"><span class="math-identifier">&#x412;</span><span class="math-identifier">&#x440;</span><span class="math-identifier">&#x435;</span><span class="math-identifier">&#x43C;</span><span class="math-identifier">&#x44F;</span></span></span></span></span></span></span></span></span>'
}
end

module AsciiMathHelper
  def expect_mathml(asciimath, mathml)
    expect(AsciiMath.parse(asciimath).to_mathml).to eq(mathml)
  end
  
  def expect_html(asciimath, html)
    expect(AsciiMath.parse(asciimath).to_html).to eq(html)
  end
end

RSpec.configure do |c|
  c.include AsciiMathHelper
end

describe "AsciiMath::MathMLBuilder" do
  TEST_CASES.each_pair do |asciimath, output|
    it "'#{asciimath}' to MathML" do
      expect_mathml(asciimath, output[:mathml])
    end
  end
end

describe "AsciiMath::HTMLBuilder" do
  TEST_CASES.each_pair do |asciimath, output|
    if output[:html]
      it "'#{asciimath}' to HTML" do
        expect_html(asciimath, output[:html])
      end
    end
  end
end