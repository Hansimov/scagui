function dataDownSample(~,~)
    global file_pointer file_container;
    for i = 1:size(file_pointer,1)
        if file_pointer{i,1}
            sample_out = file_container{i,1}.downsample(10);
            plotResult(sample_out);
        end
    end
end