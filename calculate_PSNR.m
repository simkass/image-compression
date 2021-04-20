function PSNR = calculate_PSNR(Is, Id, L, C)
    max_value = max(Is(:));

    % Calculate Errors squared
    errors_squared = (Is - Id).^2;

    % Calculate Mean Squared Error
    MSE = sum(errors_squared(:)) / (L * C);

    % Calculate PSNR
    PSNR = 20 * log10(double(max_value)) - 10 * log10(MSE);