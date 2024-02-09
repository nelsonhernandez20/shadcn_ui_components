class CodeblockComponent < ViewComponent::Base
  FORMATTER = ::Rouge::Formatters::HTML.new
  ROUGE_CSS = Rouge::Themes::Github.mode(:dark).render(scope: ".highlight")
  CUSTOM_CSS =".highlight table td { padding: 5px; }
  .highlight table pre { margin: 0; }
  .highlight, .highlight .w {
    color: #c9d1d9;
    background-color: #161b22;
  }
  .highlight .k, .highlight .kd, .highlight .kn, .highlight .kp, .highlight .kr, .highlight .kt, .highlight .kv {
    color: #ff7b72;
  }
  .highlight .gr {
    color: #f0f6fc;
  }
  .highlight .gd {
    color: #ffdcd7;
    background-color: #67060c;
  }
  .highlight .nb {
    color: #ffa657;
  }
  .highlight .nc {
    color: #ffa657;
  }
  .highlight .no {
    color: #ffa657;
  }
  .highlight .nn {
    color: #ffa657;
  }
  .highlight .sr {
    color: #7ee787;
  }
  .highlight .na {
    color: #7ee787;
  }
  .highlight .nt {
    color: #7ee787;
  }
  .highlight .gi {
    color: #aff5b4;
    background-color: #033a16;
  }
  .highlight .kc {
    color: #79c0ff;
  }
  .highlight .l, .highlight .ld, .highlight .m, .highlight .mb, .highlight .mf, .highlight .mh, .highlight .mi, .highlight .il, .highlight .mo, .highlight .mx {
    color: #79c0ff;
  }
  .highlight .sb {
    color: #79c0ff;
  }
  .highlight .bp {
    color: #79c0ff;
  }
  .highlight .ne {
    color: #79c0ff;
  }
  .highlight .nl {
    color: #79c0ff;
  }
  .highlight .py {
    color: #79c0ff;
  }
  .highlight .nv, .highlight .vc, .highlight .vg, .highlight .vi, .highlight .vm {
    color: #79c0ff;
  }
  .highlight .o, .highlight .ow {
    color: #79c0ff;
  }
  .highlight .gh {
    color: #1f6feb;
    font-weight: bold;
  }
  .highlight .gu {
    color: #1f6feb;
    font-weight: bold;
  }
  .highlight .s, .highlight .sa, .highlight .sc, .highlight .dl, .highlight .sd, .highlight .s2, .highlight .se, .highlight .sh, .highlight .sx, .highlight .s1, .highlight .ss {
    color: #a5d6ff;
  }
  .highlight .nd {
    color: #d2a8ff;
  }
  .highlight .nf, .highlight .fm {
    color: #d2a8ff;
  }
  .highlight .err {
    color: #f0f6fc;
    background-color: #8e1519;
  }
  .highlight .c, .highlight .ch, .highlight .cd, .highlight .cm, .highlight .cp, .highlight .cpf, .highlight .c1, .highlight .cs {
    color: #8b949e;
  }
  .highlight .gl {
    color: #8b949e;
  }
  .highlight .gt {
    color: #8b949e;
  }
  .highlight .ni {
    color: #c9d1d9;
  }
  .highlight .si {
    color: #c9d1d9;
  }
  .highlight .ge {
    color: #c9d1d9;
    font-style: italic;
  }
  .highlight .gs {
    color: #c9d1d9;
    font-weight: bold;
  }"

  def initialize(code:"def hello_world\n  puts \"Hello, worldzzzz!\"\nend", syntax: :ruby, clipboard: false, clipboard_success: "Copied!", clipboard_error: "Copy failed!", **attrs)
    @code = code
    @syntax = syntax.to_sym
    @clipboard = clipboard
    @clipboard_success = clipboard_success
    @clipboard_error = clipboard_error

    if @syntax == :ruby || @syntax == :html
      @code = @code.gsub(/(?:^|\G) {2}/m, "	")
    end

    @attrs = attrs.merge(class: "highlight text-sm max-h-[350px] after:content-none flex font-mono overflow-auto overflow-x rounded-md border !bg-stone-900 [&_pre]:p-4")
  end

  def call
    content_tag :div, class: "w-full relative" do
      safe_join([style_tag, content])
    end
  end

  private

  def style_tag
    content_tag :style, CUSTOM_CSS.html_safe
  end

  def content
    if @clipboard
      with_clipboard
    else
      codeblock
    end
  end

  def default_attrs
    {
      class: "highlight text-sm max-h-[350px] after:content-none flex font-mono overflow-auto overflow-x rounded-md border !bg-stone-900 [&_pre]:p-4"
    }
  end

  def with_clipboard
    safe_join([
      codeblock,
      content_tag(:div ,class: "absolute top-2 right-2") do
        content_tag(:div, data: { clipboard_target: "trigger", action: "click->clipboard#copy" }) do
          content_tag(:button, type: "button", class: "whitespace-nowrap inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 hover:bg-accent hover:text-accent-foreground h-6 w-6 text-white hover:text-white hover:bg-white/20") do
            content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor", class: "w-4 h-4") do
              content_tag(:path, stroke_linecap: "round", stroke_linejoin: "round", d: "M16.5 8.25V6a2.25 2.25 0 00-2.25-2.25H6A2.25 2.25 0 003.75 6v8.25A2.25 2.25 0 006 16.5h2.25m8.25-8.25H18a2.25 2.25 0 012.25 2.25V18A2.25 2.25 0 0118 20.25h-7.5A2.25 2.25 0 018.25 18v-1.5m8.25-8.25h-6a2.25 2.25 0 00-2.25 2.25v6")
            end
          end
        end
      end
    ])
  end

  def codeblock
    content_tag :div, data: { clipboard_target: "source" } do
      content_tag :div, **@attrs do
        content_tag :div, class: "after:content-none" do
          content_tag :pre do
            FORMATTER.format(lexer.lex(@code)).html_safe
          end
        end
      end
    end
  end

  def lexer
    Rouge::Lexer.find(@syntax)
  end

  # def clipboard_icon
  #   # Aquí necesitarías implementar tu propio método para generar el icono del portapapeles.
  # end

  def check_icon
    # Aquí necesitarías implementar tu propio método para generar el icono de verificación.
  end
end
