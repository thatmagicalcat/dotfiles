{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];

        settings = {
          global = {
            macro_sequence_timeout = 10;
          };

          main = {
            control = "capslock";
            capslock = "overload(control, escape)";
          };

          control = {
            # retyping C-enter for the window-manager to pickup and show vim mode notification
            enter = "togglem(vim, C-enter)";
          };

          vim = {
            # typing C-S-enter for the window-manager to pickup and clear the vim mode notification
            escape = "clearm(macro(escape C-S-enter))"; # passthrough escape as well
            enter = "clearm(macro(enter C-S-enter))"; # passthrough enter as well
            i = "clearm(C-S-enter)";
            a = "clearm(macro(right C-S-enter))";
            o = "clearm(macro(end enter down C-S-enter))";
            O = "clearm(macro(home enter up C-S-enter))";
            c = "clearm(macro(backspace C-S-enter))";

            h = "left";
            j = "down";
            k = "up";
            l = "right";
            b = "macro(C-left)";
            e = "macro(C-right)";
            "0" = "macro(home)";

            d = "macro(C-backspace)";
            y = "macro(C-c)";
            p = "macro(C-v)";
            u = "macro(C-z)";

            v = "togglem(visual, C-A-enter)";
            shift = "layer(vim_shift)";
            capslock = "overload(vim_control, clearm(macro(escape C-S-enter)))";
          };

          "visual:S" = {
            enter = "togglem(visual, C-A-S-enter)";
            d = "togglem(visual, macro(C-backspace C-A-S-enter))";
            capslock = "togglem(visual, macro(escape C-A-S-enter))";
          };

          vim_shift = {
            "4" = "macro(end)";
            o = "clearm(macro(home enter up C-S-enter))";
            a = "clearm(macro(end C-S-enter))";
            i = "clearm(macro(home C-S-enter))";
          };

          vim_control = {
            enter = "clearm(C-S-enter)";
            u = "pageup";
            d = "pagedown";
            r = "macro(C-y)";
          };
        };
      };
    };
  };

}
