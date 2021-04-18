function PSNR = calculate_PSNR(Is, Id)
    max_value = max(Is(:));

    % Calculate Errors squared
    errors_squared = (Is - Id).^2;

    % Calculate Mean Squared Error
    MSE = sum(errors_squared(:)) / (L * C);

    % Calculate PSNR
    PSNR = 20 * log10(max_value) - 10 * log10(MSE)