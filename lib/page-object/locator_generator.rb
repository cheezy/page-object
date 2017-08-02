module PageObject
  module LocatorGenerator

    BASIC_ELEMENTS = %i(
        abbr
        address
        animate
        animate_motion
        animate_transform
        article
        as
        aside
        base
        bdi
        bdo
        blockquote
        body
        br
        caption
        circle
        cite
        code
        col
        colgroup
        command
        cursor
        data
        datalist
        dd
        defs
        del
        desc
        details
        dfn
        dialog
        discard
        dl
        dt
        ellipse
        em
        embed
        fieldset
        figcaption
        figure
        font
        footer
        foreign_object
        g
        head
        header
        hgroup
        hr
        html
        ins
        kbd
        keygen
        legend
        line
        linear_gradient
        main
        map
        mark
        marker
        menu
        menuitem
        mesh_gradient
        mesh_patch
        mesh_row
        meta
        metadata
        meter
        mpath
        nav
        noscript
        object
        optgroup
        output
        p
        param
        path
        pattern
        polygon
        polyline
        pre
        progress
        q
        radial_gradient
        rect
        rp
        rt
        ruby
        s
        samp
        script
        section
        set
        small
        source
        stop
        strong
        style
        sub
        summary
        sup
        switch
        symbol
        template
        text_path
        thread
        time
        title
        track
        tspan
        u
        use
        var
        view
        wbr
    )


    ADVANCED_ELEMENTS = %i(
        text_field
        hidden_field
        text_area
        select_list
        link
        checkbox
        radio_button
        button
        div
        span
        table
        cell
        row
        image
        form
        list_item
        ordered_list
        unordered_list
        h1
        h2
        h3
        h4
        h5
        h6
        paragraph
        label
        file_field
        area
        canvas
        audio
        video
        b
        i
        svg
    )

    def self.generate_locators(target)
      ADVANCED_ELEMENTS.each do |tag|
        target.send(:define_method, "#{tag.to_s}_element") do |*identifier|
          @platform.send "#{tag.to_s}_for", locator(identifier)
        end

        target.send(:define_method, "#{tag.to_s}_elements") do |*identifier|
          @platform.send("#{tag.to_s}s_for", identifier[0] ? identifier[0] : {})
        end
      end

      BASIC_ELEMENTS.each do |tag|
        target.send(:define_method, "#{tag.to_s}_element") do |*identifier|
          @platform.send :element_for, tag, locator(identifier)
        end

        target.send(:define_method, "#{tag.to_s}_elements") do |*identifier|
          @platform.send(:elements_for, tag, identifier[0] ? identifier[0] : {})
        end
      end
    end

  end
end
