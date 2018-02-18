function dataDownSample(~,~)
    global container;
    for i = 1:size(container.file_pointers,1)
        if container.file_pointers{i,1}
            sample_out = container.files{i,1}.downsample(10);
            plotResult(sample_out);
        end
    end
end