function test_jslider()

    import javax.swing.*

    figure;


    % dbrm = DefaultBoundedRangeModel(1,2,1,10);
    % init, extent, min, max
    jsl = JSlider();

    jsl.setMinimum(1);
    jsl.setMaximum(100+1);
    jsl.setExtent(1);
    jsl.setValue(1);
    set(jsl,'StateChangedCallback',@sliderChanged);

    % uiinspect(js);
    [jslider, mslider] = javacomponent(jsl);
    mslider.Position(3) = 200;


    sm = javax.swing.SpinnerNumberModel(1,1,100,1);
    % default, min, max, step
    jsp = JSpinner(sm);
    set(jsp,'StateChangedCallback',@spinnerStateChanged);
    set(jsp,'MouseWheelMovedCallback',@spinnerInputChanged);
    [jspinner, mspinner] = javacomponent(jsp);
    mspinner.Position(2) = 200;

    function sliderChanged(src,data)
        slider_val = src.getValue;
        jsp.setValue(src.getValue);
    end

    function spinnerStateChanged(src,data)
        spinner_val = src.getValue;
        jsl.setValue(src.getValue);
    end
    function spinnerInputChanged(src,data)
        src.getValue
    end

end